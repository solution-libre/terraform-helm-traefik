apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: ${name}-strip-prefix
  namespace: ${namespace}
spec:
  stripPrefix:
%{ if force_slash != null ~}
    forceSlash: ${force_slash}
%{ endif ~}
    prefixes:
      ${indent(6, yamlencode(prefixes))}
