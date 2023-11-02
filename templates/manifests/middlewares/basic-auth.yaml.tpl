apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: ${name}-basic-auth
  namespace: ${namespace}
spec:
  basicAuth:
    secret: ${name}-basic-auth
