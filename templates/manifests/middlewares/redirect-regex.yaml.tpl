apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: ${name}-redirect
  namespace: ${namespace}
spec:
  redirectRegex:
    permanent: ${permanent}
    regex: '${regex}'
    replacement: '${replacement}'
