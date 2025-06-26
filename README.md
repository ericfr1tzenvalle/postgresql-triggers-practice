# Exercícios de Banco de Dados (PostgreSQL)

## 🗂️ Estrutura
- Scripts para **criação de tabelas**, inserções e estabelecimento de constraints (`CHECK`, `FK`, `PK`, `UNIQUE`).
- Modelagem com as entidades:
  - `cliente`, `categoria`, `filme`, `status`, `dvd`, `locacao` e `reserva`.

---

## ⚡️ Triggers e Funções

### 1️⃣ Log de Operações em DVDs
- **Função:** `log_dvd()`  
  Registra todas as operações de **inserção**, **atualização** e **deleção** realizadas na tabela `dvd`.

---

### 2️⃣ Status Automático
#### A) Entrega do DVD
- **Função:** `atualiza_status_entrega()`  
  Quando `data_devolucao` não estiver vazia, atualiza o status do DVD para **disponível**.

#### B) Reserva do DVD
- **Função:** `atualiza_status_reserva()`  
  Verifica o status atual do DVD e atualiza para **reservado** se estiver **disponível**.

---

### 3️⃣ Controle de Locações
- **Função:** `controla_locacao()`  
  Verifica status atual do DVD:
    - Se **disponível** ➔ atualiza para `locado`.
    - Se **reservado** ➔ verifica se o cliente atual tem a reserva:
      - ✅ Se sim, atualiza para `locado`.
      - ❌ Se não, impede e retorna mensagem de erro: **“Reserva para outro cliente!”**
    - Se **locado** ➔ impede nova locação e retorna mensagem de erro: **“DVD locado!”**

---

## ✅ Resultado Final
Scripts para prática de:
- Modelagem de tabelas relacionais.
- Aplicação de constraints (`CHECK`, `FK`, `PK`, `UNIQUE`).
- Triggers para automação e controle de status de registros.
- Tratamento de exceções e lógica de negócio direto no nível do banco de dados.