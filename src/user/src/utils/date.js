import moment from 'moment'

// 设置中文语言
moment.locale('zh-cn')

/**
 * 格式化日期时间
 * @param {String|Date} date - 日期
 * @param {String} format - 格式
 * @returns {String}
 */
export function formatDateTime (date, format = 'YYYY-MM-DD HH:mm:ss') {
  if (!date) return ''
  return moment(date).format(format)
}

/**
 * 格式化日期
 */
export function formatDate (date) {
  return formatDateTime(date, 'YYYY-MM-DD')
}

/**
 * 格式化为相对时间（如：3小时前）
 */
export function fromNow (date) {
  if (!date) return ''
  return moment(date).fromNow()
}

/**
 * 获取当前时间
 */
export function now () {
  return moment().format('YYYY-MM-DD HH:mm:ss')
}
