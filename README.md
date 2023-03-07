# Pix Copia e Cola e QRCode

É necessário informar a chave pix, nome do estabelecimento e cidade.

Opcionalmente, é possível informar o valor da cobrança e pedir a geração de um qrcode (depende do qrencode)

```bash
./gera.sh -c "chavepix@email.com" -n "nome do estabelecimento ou pessoa" -l "cidade" [-v "valor"] [-i]"
```

# Dependências
- qrencode
