stripPrefix:
%{ if force_slash != null ~}
  forceSlash: ${force_slash}
%{ endif ~}
  prefixes:
    ${indent(6, yamlencode(prefixes))}
