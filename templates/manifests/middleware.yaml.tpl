apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: ${name}-default
  namespace: ${namespace}
spec:
  headers:
    #frameDeny: true
    browserXssFilter: true
    contentTypeNosniff: true
    stsIncludeSubdomains: true
    stsSeconds: 315360000
    stsPreload: true