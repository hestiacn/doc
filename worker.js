import { getAssetFromKV } from '@cloudflare/kv-asset-handler'

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  try {
    // ⚠️ SPA路由重定向逻辑
    const url = new URL(request.url)
    if (!url.pathname.includes('.')) {
      return new Response(null, {
        status: 302,
        headers: { 'Location': '/index.html' }
      })
    }
    
    return await getAssetFromKV(event)
  } catch (e) {
    return new Response('404 Not Found', { status: 404 })
  }
}