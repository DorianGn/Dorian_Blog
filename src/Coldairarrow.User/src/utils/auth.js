const TOKEN_KEY = 'blog_token'

/**
 * 获取Token
 */
export function getToken () {
  return localStorage.getItem(TOKEN_KEY)
}

/**
 * 设置Token
 */
export function setToken (token) {
  return localStorage.setItem(TOKEN_KEY, token)
}

/**
 * 删除Token
 */
export function removeToken () {
  return localStorage.removeItem(TOKEN_KEY)
}

/**
 * 检查是否已登录
 */
export function isLoggedIn () {
  return !!getToken()
}
