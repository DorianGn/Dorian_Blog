import md5 from 'md5'
import { v4 as uuidv4 } from 'uuid'
import moment from 'moment'

/**
 * 生成请求签名
 * 签名规则: md5(appId + time + guid + body + appSecret)
 * @param {Object} data - 请求数据
 * @returns {Object} 签名信息
 */
export function generateSign (data) {
  const appId = process.env.VUE_APP_AppId
  const appSecret = process.env.VUE_APP_AppSecret
  const guid = uuidv4()
  const time = moment().format('YYYY-MM-DD HH:mm:ss')

  // 将请求数据转为JSON字符串
  const body = data ? JSON.stringify(data) : ''

  // 生成MD5签名
  const sign = md5(appId + time + guid + body + appSecret)

  return {
    appId,
    time,
    guid,
    sign
  }
}
