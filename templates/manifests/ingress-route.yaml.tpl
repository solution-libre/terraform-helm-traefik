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
%{ if www_redirect || length(middlewares) > 0 }
      middlewares:
%{ endif }
%{ if www_redirect }
        - name: www-redirectregex
%{ endif }
%{ if length(middlewares) > 0 }
%{ for middleware in middlewares }
        - name: ${middleware}
%{ endfor }
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
