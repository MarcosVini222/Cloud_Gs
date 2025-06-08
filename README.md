🚨 Projeto: Sistema de Localização Segura


👨‍💻 Desenvolvedores

  Pedro Cardoso - RM555160
  
  Marcos Lourenço - RM556496
  
  Heitor Ortega - RM557825


📝 Descrição do Projeto

  Este é um sistema backend em Java com Spring Boot que fornece uma API REST para cadastro de usuários, localizações e gerenciamento de lugares seguros, como escolas e delegacias próximas, 
  utilizando a API Overpass e o serviço Nominatim. O sistema conta com autenticação JWT e controle de acesso baseado em roles (ADMIN e USER). Tudo isso para priorizar a vida das pessoas em riscos
  em relações aos desastres naturais. No nosso app (integrado com a API) você consegue colocar os lembretes que deseja, e achar um local seguro para ir, a partir da sua localização.



💻 Tecnologias Utilizadas

  ⚙️ Spring Boot
  
  🌐 Spring Web
  
  🗃️ Spring Data JPA
  
  🔐 Spring Security com JWT
  
  ✅ Bean Validation (Jakarta Validation)
  
  📄 Paginação com Pageable
  
  📖 Swagger (Springdoc OpenAPI)
  
  🧠 Banco de Dados Oracle

  
  
🚀 Como Rodar o Projeto

- É necessário clonar este repositório primeiramente, abra seu git bash em uma pasta que você queira deixar o projeto, e de um git clone urlDoRepositorio
- Após isso, abra o INTELIJI (IDE QUE BASEAMOS O PROJETO), e abra o projeto clonado que está dentro da pasta
- Verifique primeiramente a versão usada do java na pasta build.gradle, que fica na raíz do projeto, a versão estará na linha 12. Caso não seja a mesma versão do java em que você está,
você deve ir no canto superior esquerdo, no menu sanduíche - project structure - SDK, e agorá você escolherá o sdk correto, que no caso do projeo é o 21. 
- Para rodar o projeto, no canto superior da tela, mais ao meio, terá as opções de como dar run. Selecione a seguinte opção: "GsJavaApplication", que tem um símbolo AZUL.
- Após isso, você poderá clicar no icone de play, ao lado deste que você acabou de ver agora
- Ao rodar o projeto, você pode abrir algum app de requisições, nós do projeto escolhemos o POSTMAN, mas antes, abra as pastas do projeto nessa ordem SRC - MAIN - JAVA - br.com.fiap.gsjava (se não estiver aberto)
- Ao fazer login, digite new request na barra de pesquisa e clique na primeira opção, a partir daí, você ja poderá fazer suas requisições a patir das rotas possíveis.
- Cada rota tem um tipo de requisição, GET, POST, PUT a DELETE, sabendo disso, você pode criar um lembrete, fazer um register do usuario, um login do usuario, depende da
permissão colocada em cada tipo de rota. Ou seja, você seleciona qual o tipo de requisição, coloca a URL da API, e posteriormente usa a rota criada, a lista de rotas e suas permissões estarão
logo abaixo.
- As requisições POST, PUT e DELETE precisam de um JSON como BODY, você consegue selecionar isso também, logo abaixo da url + rotas, selecione body e JSON. É necessário entender que os bodys mudam de acordo
com a rota, para identificar, veja as classes requests (no caso do put e post) passadas nos parâmetros das ClassesController (dentro do pacote "controller"), a partir daí, você identifica qual tipo de classeRequest, e procura essa mesma classe no pacote "DTO".
Você precisa entender que o corpo do json vai ser igual aos nomes dos atributos nas classes de DTO, então por exemplo, se meu POST de lembrete recebe um LembreteRequestDTO, a requisição vai ser um body json dessa meneira
    {
      "mensagem": " colocar madeiras nas janelas",
      "dataHora: "2025-06-08T15:00:00"

    }
  Após isso, clique em "send" para mandar a requisição
- PAGINADO: você consegue exibir os lembretes como se fosse uma página, basta usar essa rota /lembretes/paginado?page=0&size=5&sort=dataHora,desc
  ### O MELHOR CONTEXTO PARA CRIAÇÃO É CRIAR UM LEMBRETE ( /lembretes), REGISTRAR UM USUARIO (/auth/register), LOGAR UM USUARIO (/auth/login), EDITAR O LEMBRETE PARA COLOCAR A QUE USUARIO ELE PERTENCE (/lembretes/atualizar/email)
  ## A PARTIR DAÍ É COM VOCÊ -- QUANDO VOCÊ FIZER O REGISTER (NÃO ESQUEÇA DE COLOCAR A ROLE COMO "ADMIN" OU "USER"), AO FAZER O LOGIN COM OS MESMOS ATRIBUTOS TIRANDO A ROLE, VOCÊ RECEBERÁ A KEY, A PARTIR DELA, VOCÊ PODE FAZER AS REQUISIÇÕES QUE ESTÃO PROTEGIDAS, É NECESSÁRIO CLICAR EM AUTHORIZATION E ESCOLHER "BARRER TOKEN" E COLAR SEU TOKEN QUE VOCÊ PEGOU AO FAZER A REQUISIÇÃO DO LOGIN, A PARTIR DAÍ, VOCÊ JA PODE FAZER A REQUISIÇÃO PROTEGIDA
  ## É PERMITIDO O USUARIO FAZER UM REGISTRO PARA TESTE, MAS OBVIAMENTE, ISSO É IMPOSSÍVEL EM UM AMBIENTE ROBUSTO
### ROTAS POSSÍVEIS 

📌 Rotas e Permissões


🔓 Públicas (sem autenticação)

    POST /auth/login
        
    POST /auth/register
        
    POST /api/localizacoes/salvar
        
    POST /api/localizacoes/lugares-seguros
        
    GET /api/lugares-seguros
        
    GET /api/lugares-seguros/{id}
        
    POST /lembretes
        
    GET /lembretes/usuario/{email}
        
    GET /lembretes/paginado
        
    PUT /lembretes/atualizar
    
    PUT /lembretes/atualizar/email

🔒 Protegidas (ADMIN apenas)

    POST /api/lugares-seguros

    DELETE /api/lugares-seguros/{id}

    DELETE /lembretes/{id}



## CLOUD

# Stage 1: Build the application
FROM gradle:jdk21 AS builder
WORKDIR /app
COPY . /app
RUN gradle build -x test

# Stage 2: Create the runtime image
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar /app/app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]

  CODIGOS USADOS NOS TESTES 
Docker stop api_gs oracle_gs
Docker rm api_gs oracle_gs
Docker run --detach --publish 1521:1521 --name oracle_gs --network gs_network --volume volume_gs:/var/lib/oracle --env ORACLE_PASSWORD=ViniFiap123 --env ORACLE_DATABASE=GS_JAVA --env APP_USER=Marcos --env APP_USER_PASSWORD=ViniFiap123 gvenzl/oracle-xe
Docker image ls
docker run --detach --publish 8080:8080 --name api_gs --network gs_network --env DB_URL=jdbc:oracle:thin:@oracle_gs:1521/XEPDB1 --env DB_USER=Marcos --env DB_PASS=ViniFiap123 java_gs
Docker logs -f api_gs

Video Cloud: https://youtu.be/MqFkaC-wn5k
