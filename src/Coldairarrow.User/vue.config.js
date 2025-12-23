const path = require('path')

function resolve (dir) {
  return path.join(__dirname, dir)
}

module.exports = {
  publicPath: '/',
  outputDir: 'dist',
  assetsDir: 'static',
  lintOnSave: process.env.NODE_ENV === 'development',
  productionSourceMap: false,

  devServer: {
    port: 8080,
    open: true,
    client: {
      overlay: {
        warnings: false,
        errors: true
      }
    },
    proxy: {
      '/api': {
        target: process.env.VUE_APP_BASE_API || 'http://localhost:3000',
        changeOrigin: true,
        pathRewrite: {
          '^/api': ''
        }
      }
    }
  },

  configureWebpack: {
    resolve: {
      alias: {
        '@': resolve('src'),
        '@components': resolve('src/components'),
        '@views': resolve('src/views'),
        '@utils': resolve('src/utils'),
        '@api': resolve('src/api'),
        '@assets': resolve('src/assets')
      }
    }
  },

  chainWebpack (config) {
    // 配置svg
    config.module
      .rule('svg')
      .exclude.add(resolve('src/assets/icons'))
      .end()
  }
}
