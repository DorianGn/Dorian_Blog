import request from '@/utils/request'

/**
 * 用户登录
 */
export function login (data) {
  return request({
    url: '/Base_Manage/Home/SubmitLogin',
    method: 'post',
    data: {
      userName: data.userName,
      password: data.password
    }
  })
}

/**
 * 获取当前用户信息
 */
export function getUserInfo () {
  return request({
    url: '/Base_Manage/Home/GetOperatorInfo',
    method: 'post',
    data: {}
  })
}

/**
 * 修改密码
 */
export function changePassword (data) {
  return request({
    url: '/Base_Manage/Home/ChangePwd',
    method: 'post',
    data: {
      oldPwd: data.oldPassword,
      newPwd: data.newPassword
    }
  })
}

/**
 * 用户注册（需要后端实现）
 */
export function register (data) {
  return request({
    url: '/Base_Manage/Base_User/SaveData',
    method: 'post',
    data: {
      UserName: data.userName,
      Password: data.password,
      Email: data.email,
      UserType: 0, // 普通用户
      Status: 1 // 启用状态
    }
  })
}

/**
 * 更新用户信息
 */
export function updateUserInfo (data) {
  return request({
    url: '/Base_Manage/Base_User/SaveData',
    method: 'post',
    data
  })
}

/**
 * 上传文件
 */
export function uploadFile (file) {
  const formData = new FormData()
  formData.append('formFile', file)
  return request({
    url: '/Base_Manage/Upload/UploadFileByForm',
    method: 'post',
    data: formData,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
}
