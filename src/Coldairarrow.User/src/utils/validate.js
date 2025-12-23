/**
 * 验证邮箱
 */
export function isEmail (email) {
  const reg = /^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$/
  return reg.test(email)
}

/**
 * 验证手机号
 */
export function isPhone (phone) {
  const reg = /^1[3-9]\d{9}$/
  return reg.test(phone)
}

/**
 * 验证用户名（4-16位字母数字下划线）
 */
export function isUsername (username) {
  const reg = /^[a-zA-Z0-9_]{4,16}$/
  return reg.test(username)
}

/**
 * 验证密码（6-20位）
 */
export function isPassword (password) {
  return password && password.length >= 6 && password.length <= 20
}

/**
 * 验证URL
 */
export function isURL (url) {
  const reg = /^(https?|ftp):\/\/[^\s/$.?#].[^\s]*$/i
  return reg.test(url)
}
