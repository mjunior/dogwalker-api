# DogWalker Challenge
Seu desafio será pensar em uma estrutura que suporte usuários a pedir esse novo serviço para seus peludos. Algumas observações:

- Fique a vontade para montar o schema do banco como desejar. Apenas a entidade Dog Walking é obrigatória. Além disso, utilize o RDBS de sua preferência;

- Esta entidade deve conter: status, data de agendamento, preço, duração (30 ou 60 min), latitude, longitude, pets, horário de início e término; Fique a vontade para adicionar qualquer atributo de sua escolha;

- Você deve criar uma API para Dog Walking com index, show, create, start_walk e finish_walk;

- A API de index deve receber um filtro através de uma flag para retornar: 1-) apenas os próximos passeios a partir de hoje ou 2-) todos. Além disso, paginação não é obrigatório, mas seria um plus;

- A API para criação de passeio deve receber todos os atributos listados acima menos status;

- A API de show deve retornar a duração real do passeio, ou seja, a diferença entre o início e o término;

- O preço é calculado dinamicamente. Um passeio de 30 minutos para 1 cachorro custa R$25, sendo cada cachorro adicional R$15. Um passeio de 60 minutos para 1 cachorro custa R$35, sendo cada cachorro adicional R$20;

- Utilize Ruby on Rails para o projeto. Adicione quantas gems precisar;

- Pode desconsiderar qualquer tipo de autenticação e o retorno da API deve ser JSON.

# Docs!
<details>
<summary>Listar passeios</summary>
<pre>`GET: /dog_walkings?all=[true,false]&page=[number]`</pre>

<p>Lista todos os passeios futuros. Enviando o atributo `all=true` é listado também todas as caminhadas dos dias anteriores.  </p>
  
<br>
  <pre>
  {
    "data": [
        {
            "id": "00276f63-71d9-48ea-b968-18bffa44ad1d",
            "type": "dog_walking",
            "attributes": {
                "schedule_date": "2018-11-12T06:42:36.052Z",
                "price": 40,
                "status": "scheduled",
                "duration": 30,
                "latitude": "-23.510487",
                "longitude": "-46.882312",
                "pets": 2,
                "start_date": "2018-11-12T06:42:36.052Z",
                "end_date": "2018-11-12T07:12:36.052Z",
                "realtime_duration": null
            }
        },
        {
            "id": "8ce7ba31-0ec4-4269-8243-1f98c33dec7e",
            "type": "dog_walking",
            "attributes": {
                "schedule_date": "2018-11-12T08:42:36.070Z",
                "price": 55,
                "status": "scheduled",
                "duration": 30,
                "latitude": "-23.510487",
                "longitude": "-46.882312",
                "pets": 3,
                "start_date": "2018-11-12T08:42:36.070Z",
                "end_date": "2018-11-12T09:12:36.070Z",
                "realtime_duration": null
            }
        }
    ],
    "meta": {
        "pagination": {
            "current": 1,
            "previous": null,
            "next": null,
            "per_page": 10,
            "pages": 1,
            "total": 2
        }
    }
}
  </pre>
</details>

<details>
<summary>Informações de um passeio</summary>
  <pre>`GET: /dog_walkings/:uuid`</pre>
  <p>Exibe informaçes de um passeio com o tempo real de duração </p>
<br>
  <pre>
  {
    "data": {
        "id": "b2646aa1-445c-4fae-b17c-027ee4daaada",
        "type": "dog_walking",
        "attributes": {
            "schedule_date": "2018-11-12T10:42:36.107Z",
            "price": 55,
            "status": "scheduled",
            "duration": 30,
            "latitude": "-23.510487",
            "longitude": "-46.882312",
            "pets": 3,
            "start_date": "2018-11-12T10:42:36.107Z",
            "end_date": "2018-11-12T11:12:36.107Z",
            "realtime_duration": 30
        }
    }
}
  </pre>
</details>


<details>
<summary>Criar de um passeio</summary>
  <pre>`POST: /dog_walkings`</pre>
  <p>Cria um passeio</p>
  <ul>
   <li><b>schedule_date</b>: Data do passeio</li>
   <li><b>pets</b>: Total de pets no passeio. (deve ser maior que zero)</li>
   <li><b>latitude/longitude</b>: Coordenadas para inicio do passeio</li>
    <li><b>Duration</b>: Tempo de duração. (Deve ser 30 ou 60)</li>
  </ul>
<br>
  <pre>
  {
	"dog_walking": {
		"schedule_date": "2018-11-13T08:51:03.266Z",
            "duration": 60,
            "latitude": "-23.510487",
            "longitude": "-46.882312",
            "pets": 2,
            }
}
  </pre>
</details>

<details>
<summary>Inicia um passeio</summary>
  <pre>`PATCH: /dog_walkings/:uuid/start_walking`</pre>
  <p>Inicia um passeio. Não é possivel iniciar um passeio finalizado ou em andamento</p>
<br>
  <pre>
    HTTP_STATUS 200
  </pre>
</details>

<details>
<summary>Encerrar um passeio</summary>
  <pre>`PATCH: /dog_walkings/:uuid/finish_walking`</pre>
  <p>Finaliza um passeio. Não é possivel finalizar um passeio agendado ou já finalizado</p>
<br>
  <pre>
    HTTP_STATUS 200
  </pre>
</details>


<details>
<summary>Retorno de Errors</summary>
  <p>Um Hash de Erros é retornado. Cada Key deste Hash é referente ao campo invaliado. Um Array de String é retornado em cada Key com as mensagens de error</p>
<br>
  <pre>
{
    "errors": {
        "duration": [
            "20.0 is not a valid duration"
        ],
        "pets": [
            "must be greater than 0"
        ]
    }
}
  </pre>
</details>

## Specs
```json
DogWalking
  .create
     creates with a correct price for more than one pets
     creates with a correct price for one pet
     creates with a correct status
     

DogWalking Create With Errors Api
  POST /dog_walking
    When invalid attributes
      returns message errors messages
      returns status unprocessable_entity
      returns must be greater than 0
      returns schedule_date can't be blank
      returns duration is not valid


DogWalking Create Without Errors Api
  GET /dog_walking
    When valid attributes
      returns status :OK
      returns a walk
      returns walk with correct status
      returns walk with a price

DogWalking Finish Errors Api
  GET /dog_walking/:id/finish_start
    When to finish a walk that is scheduled
      returns errors
      returns status unprocessable_entity
      returns message error
    When to finish a walk alredy finished
      returns errors
      returns message error

DogWalking End Without Errors Api
  GET /dog_walking/:id/finish_walk
    When start walk with a valid uuid
      returns status :OK 200
      changes walk status to finished
      changes walk end_date
    When Finish with a invalid uuid
      returns status :not_found 404

DogWalking index Api
  GET /dog_walking
    When to list only future walks
      returns status :OK
      returns a list of dog walkings
    When to list all walks
      returns status :OK
      returns a list of dog walkings

DogWalking Show Api
  GET /dog_walking/:id
    When to list only future walks
      returns status :OK
      returns a correct walk
      returns correct realtime duration

DogWalking Start Errors Api
  GET /dog_walking/:id/start_walki
    When to start a walk that is in progress
      returns errors
```

