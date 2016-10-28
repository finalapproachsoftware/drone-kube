apiVersion: v1
kind: Secret
metadata:
  name: drone-secrets
type: Opaque
data:
  server.secret: REPLACE-THIS-WITH-BASE64-ENCODED-VALUE
  server.remote.github.secret: xxxxxxxxxxxxxxxxxxxxxxxxx