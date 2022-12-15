apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: ${name}-default
  namespace: ${namespace}
spec:
  headers:
    frameDeny: ${security_headers.frame_deny}
    browserXssFilter: ${security_headers.browser_xss_filter}
    contentTypeNosniff: ${security_headers.content_type_nosniff}
    stsIncludeSubdomains: ${security_headers.sts.include_subdomains}
    stsSeconds: ${security_headers.sts.seconds}
    stsPreload: ${security_headers.sts.preload}
