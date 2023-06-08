apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: from-www-to-non-www-redirect
  namespace: ${namespace}
spec:
  redirectRegex:
    permanent: true
    regex: '^https?://www\.(.+)'
    replacement: 'https://$1'
