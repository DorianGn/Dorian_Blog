using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using System;
using System.Threading.Tasks;

namespace Coldairarrow.Util
{
    public class Email163Service
    {
        private readonly string _smtpServer;
        private readonly int _port;
        private readonly string _fromEmail;
        private readonly string _authCode;
        private readonly string _fromName;
        private readonly ILogger<Email163Service> _logger;
        string _sendEmail;
        string _sendCode;
       
        // 使用依赖注入获取配置
        public Email163Service(IConfiguration configuration, ILogger<Email163Service> logger = null)
        {
            _smtpServer = configuration["Email:SmtpServer"] ?? "smtp.163.com";
            _port = int.Parse(configuration["Email:Port"] ?? "465");
            _fromEmail = configuration["Email:FromEmail"]
                ?? throw new ArgumentException("Email:FromEmail 未配置");
            _authCode = configuration["Email:AuthCode"]
                ?? throw new ArgumentException("Email:AuthCode 未配置");
            _fromName = configuration["Email:FromName"] ?? "System";
            _logger = logger;
        }

        /// <summary>
        /// 发送验证码邮件（异步）
        /// </summary>
        public async Task<(bool Success, string ErrorMessage)> SendVerificationCodeAsync(
            string toEmail,
            string code,
            int expiryMinutes = 5)
        {
            // 参数验证
            if (string.IsNullOrWhiteSpace(toEmail))
                return (false, "收件人邮箱不能为空");

            if (string.IsNullOrWhiteSpace(code))
                return (false, "验证码不能为空");

            try
            {
                _sendEmail = toEmail;
                _sendCode = code;
                var message = CreateVerificationMessage(toEmail, code, expiryMinutes);

                using var client = new SmtpClient();

                // 设置超时
                client.Timeout = 30000; // 30秒

                // 连接到SMTP服务器
                await client.ConnectAsync(_smtpServer, _port, SecureSocketOptions.SslOnConnect);

                // 身份验证
                await client.AuthenticateAsync(_fromEmail, _authCode);

                // 发送邮件
                await client.SendAsync(message);

                // 断开连接
                await client.DisconnectAsync(true);

                _logger?.LogInformation("验证码已成功发送到 {Email}", toEmail);
                return (true, null);
            }
            catch (AuthenticationException authEx)
            {
                var error = $"SMTP认证失败: {authEx.Message}";
                _logger?.LogError(authEx, error);
                return (false, "邮件服务认证失败，请联系管理员");
            }
            catch (SmtpCommandException smtpEx)
            {
                var error = $"SMTP命令错误: {smtpEx.Message}";
                _logger?.LogError(smtpEx, error);
                return (false, "邮件发送失败，请稍后重试");
            }
            catch (Exception ex)
            {
                _logger?.LogError(ex, "发送邮件时发生未知错误");
                return (false, "邮件发送失败");
            }
        }

        public async Task<bool> VerifyCodeAsync(string email, string verifyCode)
        {
            if(_sendEmail == email && _sendCode == verifyCode)
            {
                return true;
            }
            return false;
        }

        /// <summary>
        /// 创建验证码邮件消息
        /// </summary>
        private MimeMessage CreateVerificationMessage(string toEmail, string code, int expiryMinutes)
        {
            var message = new MimeMessage();
            message.From.Add(new MailboxAddress(_fromName, _fromEmail));
            message.To.Add(new MailboxAddress("", toEmail));
            message.Subject = "邮箱验证码";

            var bodyBuilder = new BodyBuilder
            {
                HtmlBody = $@"
                            <!DOCTYPE html>
                                <html>
                                    <head>
                                        <meta charset='utf-8'>
                                        <style>
                                            body {{ margin: 0; padding: 0; background-color: #f4f4f4; }}
                                            .container {{ 
                                                max-width: 600px; 
                                                margin: 20px auto; 
                                                padding: 30px; 
                                                background-color: #ffffff;
                                                border-radius: 10px;
                                                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                                                font-family: 'Segoe UI', Arial, sans-serif; 
                                            }}
                                            .header {{ 
                                                text-align: center; 
                                                color: #333; 
                                                border-bottom: 2px solid #4CAF50;
                                                padding-bottom: 20px;
                                                margin-bottom: 30px;
                                            }}
                                            .code {{ 
                                                font-size: 32px; 
                                                font-weight: bold; 
                                                color: #4CAF50; 
                                                padding: 20px;
                                                background-color: #f9f9f9;
                                                border: 2px dashed #4CAF50;
                                                border-radius: 8px;
                                                text-align: center;
                                                letter-spacing: 5px;
                                                margin: 20px 0;
                                            }}
                                            .note {{ 
                                                color: #666; 
                                                font-size: 14px; 
                                                line-height: 1.6;
                                                margin: 10px 0;
                                            }}
                                            .warning {{ color: #ff6b6b; font-weight: bold; }}
                                            .footer {{
                                                margin-top: 30px;
                                                padding-top: 20px;
                                                border-top: 1px solid #eee;
                                                text-align: center;
                                                color: #999;
                                                font-size: 12px;
                                            }}
                                        </style>
                                    </head>
                                    <body>
                                        <div class='container'>
                                            <div class='header'>
                                                <h2>🔐 邮箱验证</h2>
                                            </div>
                                            <p>您好！</p>
                                            <p>您正在进行邮箱验证，您的验证码是：</p>
                                            <div class='code'>{code}</div>
                                            <p class='note'>验证码 <span class='warning'>{expiryMinutes} 分钟内有效</span>，请尽快完成验证。</p>
                                            <p class='note'>⚠️ 请勿将验证码泄露给他人。</p>
                                            <p class='note'>如非本人操作，请忽略此邮件。</p>
                                            <div class='footer'>
                                                <p>此邮件由系统自动发送，请勿回复</p>
                                                <p>© {DateTime.Now.Year} {_fromName}</p>
                                            </div>
                                        </div>
                                    </body>
                                    </html>",
                TextBody = $@"
                                        您的验证码是：{code}

                                        验证码 {expiryMinutes} 分钟内有效，请勿泄露。
                                        如非本人操作，请忽略此邮件。

                                        此邮件由系统自动发送，请勿回复。
                                        "
            };

            message.Body = bodyBuilder.ToMessageBody();
            return message;
        }
    }

}


