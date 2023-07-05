apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: basic-auth
  namespace: ${namespace}
spec:
  basicAuth:
    secret: ${name}-basic-auth
