
## Decisões tomadas
Explicação de raciocínio seguido para tomada de decisões de etapas e tecnologias

### 1. To-do list </br>

Decidi criar a seção *Timeline de Ações* no próprio arquivo README para registrar e exibir o passo a passo que julguei necessários para organizar meu próprio pensamento (uma vez que a missão é divida em 3 etapas com suas próprias complexidades). Passos esses referentes a: <br/>
- Qual API PHP utilizar, como inicia-la e o que faria para containeriza-la?
- Mesmo não precisando ter uma infraestrutura "de pé", o que faria para provisionar o cluster EKS sem precisar ter uma conta free tier na AWS?
- Definir arquivos de manifesto dos recursos K8S

### 2. Infraestrutura
- Devido ao prazo, optei por seguir com EKS pois é a tecnologia que tenho maior domínio e experiência. </br> Também julgo o EKS melhor para extender em quantidade de container se tratando de APIs. ECS é bom para adaptar aplicações para container de forma mais simples, mas EKS é mais robusto e possui maior flexibilidade e divisão de recursos (comparado ao ECS que utiliza, por exemplo 0,5 vCPU com quantidade de RAM definida para cada tarefa) </br>
<!-- - Iniciei validando minha ideia de infraestrutura ao invés de containerizar a API pois julguei ser mais desafiador, uma vez que tenho experiência com Dockerfile mas com LocalStack não. Se não funcionasse, seguiria apenas adicionando os arquivos .tf e .yaml no repositório. -->
- Decidi provisionar sim o cluster, pois sendo sincera, me incomoda pensar que "os arquivos terraform e manifestos k8s funcionam em teoria". </br>
Logo lembrei da tecnologia LocalStack, que emula o ambiente cloud localmente. Nunca utilizei, mas após alguns testes na pipeline *.github/workflows/localstack-test.yml* percebi que era possível seguir com ela no projeto dentro do prazo

### 3. API
- Em primeiro momento não levei em consideração o código em si pois foquei na infraestrutura e provisionamento. Logo, escolhi um dos primeiros repositórios do Github que funcionasse bem ao fazer as requisições. Mas pensando com mais calma agora, eu teria escolhido uma aplicação em Laravel pois acredito ser é mais próximo de uma API em produção. E provavelmente é possível gerar o binário de produção (como um /dist do NodeJS).
- Pesquisando, também encontrei features interessantes para executar o processo da aplicação como um Daemon no próprio Dockerfile utilizando FPM e instalação de dependencias adicionais através de docker-php-ext-install. Mas não conseguirei me aprofundar em ambos os tópicos no momento. </br>
Gostaria de executar como um Daemon sim, pois confesso que usar o comando de start no Entrypoint não me parece 100% adequado, acredito que a abordagem do Daemon rodar o processo em background é melhor. Mas com meus conhecimento atuais, não conseguiria implementar isso rapidamente.

</br>

## Timeline de Ações

### API
Todos os direitos reservados da API: https://github.com/FarrelAD/Basic-PHP-RESTful-API </br></br>
[X] Escolher repositorio PHP para clonar </br>
[X] Executar API PHP com sqlite </br>
[X] Reservar direitos ao criador do repositório da API </br> 
[X] Criar Dockerfile </br>
[ ] Criar conta no Docker Hub </br>
[ ] Criar CI para publicar a imagem no registro público

### Infraestrutura
[X] Instalar e iniciar LocalStack na Action </br>
[X] Criar resource de teste com TF referenciando o LocalStack </br>
[X] Testar aws cli com localstack </br>
[X] Criar arquivo de definição de infraestrutura cluster EKS </br>
[X] Testar kubectl CLI para manusear infraestrutura </br>
[ ] Subir pod de teste para validar deploy da infra </br>
[ ] Validar cluster EKS </br>
