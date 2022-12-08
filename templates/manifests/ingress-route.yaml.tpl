apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: ${name}
  namespace: ${namespace}
spec:
  entryPoints:
    - websecure
  routes:
    - match: Host(`${hostname}`)%{ if www_redirect } || Host(`www.${hostname}`)%{ endif }
      kind: Rule
%{ if www_redirect }
      middlewares:
        - name: www-redirectregex
%{ endif }
      services:
        - name: ${service_name}
          port: ${service_port}
  tls:
    secretName: ${hostname}
%{ if www_redirect }
---
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: www-redirectregex
  namespace: ${namespace}
spec:
  redirectRegex:
    permanent: true
    regex: '^https?://www\.(.+)'
    replacement: 'https://$1'
%{ endif }
