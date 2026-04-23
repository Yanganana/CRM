const ci = require('miniprogram-ci')
const path = require('path')

const projectConfig = {
  appid: 'wxeb10f9eb370e9ad3',
  type: 'miniProgram',
  projectPath: path.resolve(__dirname, '../dist/build/mp-weixin'),
  privateKeyPath: path.resolve(__dirname, '../private.wxeb10f9eb370e9ad3.key'),
  ignores: ['node_modules/**'],
}

const project = new ci.Project(projectConfig)

async function upload() {
  console.log('🚀 开始上传到微信小程序后台...')
  
  try {
    const uploadResult = await ci.upload({
      project,
      version: '1.0.0',
      desc: 'CI 自动上传 - ' + new Date().toLocaleString(),
      setting: {
        es6: true,
        minify: true,
        autoPrefixCSS: true,
        smartExtractStyles: true,
      },
      onProgressUpdate: console.log,
    })
    
    console.log('✅ 上传成功！')
    console.log(uploadResult)
    console.log('\n👉 请前往微信公众平台“版本管理”提交审核。')
  } catch (error) {
    console.error('❌ 上传失败：', error)
    process.exit(1)
  }
}

upload()
