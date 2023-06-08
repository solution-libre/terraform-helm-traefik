apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: from-non-www-to-www-redirect
  namespace: ${namespace}
spec:
  redirectRegex:
    permanent: true
    regex: '^https?://(.+)'
    replacement: 'https://www\.$1'
