# SimpleDrawer

Para iniciar seu servidor Phoenix:

   * Instalar dependências com `mix deps.get`
   * Crie e migre seu banco de dados com `mix ecto.setup`
   * Inicie o terminal Phoenix com `mix phx.server` ou dentro do IEx com `iex -S mix phx.server`

Agora você pode acessar [`localhost:4000/api`](http://localhost:4000/api) do seu client REST.


## Rotas - "/users"

### Criar um usuário
    [POST] - ""
        -body:
            {
                "user": {
                    "name": "New user",
                    "email": "user@gmail.com"
                }
            }	
        
        -response:
            - "201 - created"
                {
                    "data": {
                        "email": "user@gmail.com"
                        "id": "4b8ac6da-40e4-4eee-90c4-1929ae2b0854",
                        "name": "New user"
                    }
                }

## Rotas - "/drawers"

### Criar um sorteio
### * Importante: para testar um dos requisitos do sistema, que é a validação de data da inscrição do usuário (usuário não pode se inscrever em sorteio encerrado), é necessário criar um sorteio com data anterior à atual, por isso é necessário comentar a validação de data do schema de drawer.
    [POST] - ""
        - body:
            {
                "drawer": {
                    "name": "New drawer",
                    "drawer_date": "2022-10-12 10:00:00"
                }
            }

        * date_format="yyyy-mm-dd hh:mm:ss"

        - response:
            - "201 - created"
                {
                    "data": {
                        "drawer_date": "2023-10-12T10:00:00Z",
                        "id": "26ec20e9-ec43-4a68-a5a1-0eb2dafc1853",
                        "name": "New user"
                    }
                }

            - "422 - Unprocessable Entity" - data inválida
                {
                    "errors": {
                        "drawer_date": [
                            "should be after %{after}."
                        ]
                    }
                }

              * Nesse caso é necessário passar uma data após a atual


### Verificar o vencedor de um sorteio

    [GET] - "/:id/results"
        - response:

            - "200 - OK"
                {
                    "data": {
                        "drawer_date": "2023-10-12T10:00:00Z",
                        "id": "bc1ddf18-8005-4492-b838-5a19e329abfa",
                        "name": "New user",
                        "winner_email": "user@gmail.com",
                        "winner_id": "4b8ac6da-40e4-4eee-90c4-1929ae2b0854",
                        "winner_name": "New user"
                    }
                }

            - "422 - Unprocessable Entity" - sorteio não encerrado
                {
                    "errors": {
                        "detail": "the given drawer is not finished yet."
                    }
                }

            - "422 - Unprocessable Entity" - sorteio não encontrado
                {
                    "errors": {
                        "detail": "the given drawer is not found."
                    }
                }


### Cadastrar um usuário em um sorteio

    [POST] - "/subscribe-user"
        - body:
            {
                "user_drawer": {
                    "drawer_id": "9744cef8-abf0-4c95-b12e-82ecd5468aed",
                    "user_id": "4b8ac6da-40e4-4eee-90c4-1929ae2b0854"
                }
            }
        
        - response:
            - "200 - OK"
                {
                    "data": "ok"
                }
  
            - "422 - Unprocessable Entity" - sorteio não encontrado
                {
                    "errors": {
                        "detail": "the given drawer is not found."
                    }
                }


## Funções auxiliares
### Realiza o sorteio com os inscritos
    iex(2)> SimpleDrawer.Drawers.draw(drawer_id)

