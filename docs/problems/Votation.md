# Problemas com a votação em larga escala


### Premissas:

1. Tem um API Gateway que verifica as requisições e as transmite para os balanceadores;
2. Temos várias zonas de votação espalhadas pelo país;
3. As informações são salvas em um DynamoDB;
4. EC2 

## Networking

Todas as urnas devem se conectar ao servidor central via regra de IP utilizada na RFC1918.
- 192.168.0.0/22
As Availability zones que iremos utilizar são as 2a, 2b


## Arquitetura
O programa que contara com uma arquitetura serveless que vai integrar a comunicação junto do DynamoDB.

### Qual problema queremos resolver?

O problema de alta número de requisições simultâneas na infraestura de um sistema de votação.

Qual tipo de solução podemos implementar para matar esse tipo de problema?

