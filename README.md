# README
## Bioapi

### Inicialização

Optei pela utilização do docker, para que possa ser rodado com qualquer maquina. Para iniciar o projeto rodar o comando abaixo, esse processo pode demorar um pouco para até montar o docker e baixar as gems
```bash
docker-compose up
```

Depois de iniciado, para utilização da primeira vez, é necessário realizar o bundle, e as ações do banco com os comandos abaixo:
```bash
docker-compose bundle install
```
```bash
docker-compose run api rake db:create && docker-compose run api rake db:migrate && docker-compose run api rake db:seed
```

### Testes
Para rodar os testes é necessário realizar as ações do banco de teste:
```bash
docker-compose run api rake db:create RAILS_ENV=test && docker-compose run api rake db:migrate RAILS_ENV=test && docker-compose run api rake db:seed RAILS_ENV=test
```
Para rodar os testes:

```bash
docker-compose run api rspec
```

### Rotas

#### Básico
**/api/v1/basic_health_units** aceita POST/PUT/GET (index e show) normalmente

#### Find UBS
**/api/v1/find_ubs** aceita apenas GET, com os parâmetros, sendo query o único obrigatório:

- Parametro **query**, é obrigatório, recebe os parâmetros de latitude e longitude como exemplo: query=-22.728090,-43.367440;
- Parametro **per_page**, não é obrigatório, recebe os parâmetro de quantidade de itens por página, por padrão seu valor é o total de itens;
- Parametro **page**, não é obrigatório, recebe os parâmetro para dizer qual página da paginação, só ira funcionar caso o per_page estiver preenchido, por padrão seu valor é 1
- Parametro **range**, não é obrigatório, recebe o parâmetro do distancia do ponto original (query) para que seja procurado as unidades próximas, por padrão seu valor é 25.



### Outros
Caso tenha algum erro na inicialização, ou for adicionar alguma gem, é preciso parar o docker e rodar o comando abaixo
```bash
docker-compose build
```

Caso opte por não rodar com docker, é necessário trocar as configurações do `config/database.yml`, rodar o projeto manualmente com rails, o banco separadamente e retirar os comandos `docker-compose run api ` e `docker-compose`.
Caso já tenha um postgres rodando, recomendo alterar para aquele mesmo endereço, ou mudar a porta no `docker-compose.yml` e no arquivo `config/database.yml`

Instalação docker e docker-compose: https://cwiki.apache.org/confluence/pages/viewpage.action?pageId=94798094