A instalação do `Poetry`, uma ferramenta de gerenciamento de dependências para Python, é bastante simples e pode ser feita de várias maneiras, dependendo do seu sistema operacional e preferências. Aqui está um guia passo a passo para instalar o `Poetry`:

### 1. Instalação em Sistemas Unix (Linux/macOS)

Você pode usar o instalador personalizado do `Poetry`, que simplifica o processo de instalação:

```bash
curl -sSL https://install.python-poetry.org | python3 -
```

Este comando baixa um script e o executa com Python para instalar o `Poetry`. O script instala automaticamente a ferramenta no diretório `$HOME/.local/bin` ou equivalente.

### 2. Instalação no Windows

No Windows, você pode usar o PowerShell para instalar o `Poetry`:

```powershell
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | py -
```

Este comando funciona de maneira semelhante ao comando Unix/Linux, baixando e executando um script que instala o `Poetry`.

### 3. Configuração do Path

Depois de instalar o `Poetry`, é uma boa prática garantir que o diretório de instalação está no seu PATH para poder executar o `Poetry` de qualquer terminal. Se o diretório não foi automaticamente adicionado ao seu PATH, você pode adicionar manualmente:

- **No Unix/Linux/macOS**:

  Adicione a seguinte linha ao seu arquivo de perfil do shell (como `.bashrc`, `.zshrc`, etc.):

  ```bash
  export PATH="$HOME/.local/bin:$PATH"
  ```
- **No Windows**:

  Você pode adicionar o diretório de instalação (geralmente `C:\Users\<username>\.poetry\bin`) ao PATH através do Painel de Controle ou usando o PowerShell:

  ```powershell
  $path = [Environment]::GetEnvironmentVariable("PATH", [EnvironmentVariableTarget]::User) + ";C:\Users\$env:USERNAME\.poetry\bin"
  [Environment]::SetEnvironmentVariable("PATH", $path, [EnvironmentVariableTarget]::User)
  ```

### 4. Verificando a Instalação

Para verificar se o `Poetry` foi instalado corretamente, você pode executar:

```bash
poetry --version
```

Se o `Poetry` estiver corretamente instalado, este comando retornará a versão instalada do `Poetry`.

### 5. Atualização do Poetry

Para atualizar o `Poetry` para a versão mais recente, você pode usar o próprio comando do `Poetry`:

```bash
poetry self update
```

### Considerações

Antes de instalar o `Poetry`, certifique-se de que você tem o Python instalado, pois o `Poetry` é uma ferramenta baseada em Python. Preferencialmente, use Python 3.6 ou superior.

Esses métodos de instalação usam um script que automatiza o processo, mas se você preferir um controle maior ou precisar de uma instalação personalizada, você pode consultar a [documentação oficial do Poetry](https://python-poetry.org/docs/) para mais opções.

### Usando o Poetry (iniciante)

Novo projeto: poetry new `<nome-do-projeto>`

Env Virtual: `poetry shell`

Criar um grupo de desenvolvimento: `poetry add --group dev <nome do pacote>`

Adicionar lib: poetry add `<nome da lib>`
