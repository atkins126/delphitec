unit DMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, Vcl.Dialogs, IniFiles, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TfmDM = class(TDataModule)
    Connection: TFDConnection;
    DriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    tbAux: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure TentarCriarDatabase;
    procedure TentarCriarTabelasERegistros;
    function TabelaExiste(aNomeTabela: String): Boolean;
    procedure ExecutaDiretoDB(aScript: String);
  public
  end;

var
  fmDM: TfmDM;

implementation

uses
  Vcl.Forms;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfmDM.DataModuleCreate(Sender: TObject);
var
  Arquivo: TIniFile;
  Caminho,
  BibliotecaMysql: string;
begin
  Caminho := ExtractFilePath(ParamStr(0));
  BibliotecaMysql := Caminho + 'libmysql.dll';
//  fmDM.DriverLink.VendorHome := ExtractFilePath(BibliotecaMysql);
  fmDM.DriverLink.VendorLib := ExtractFileName(BibliotecaMysql);
  Arquivo := TIniFile.Create(Caminho + 'db.ini');
  try
    try
      Connection.Connected := False;
      Connection.Params.Values['Server'] := Arquivo.ReadString('PROJ', 'Server', 'localhost');
      Connection.Params.Values['Database'] := '';
      Connection.Params.Values['Username'] := Arquivo.ReadString('PROJ', 'Username', 'root');
      Connection.Params.Values['Password'] := Arquivo.ReadString('PROJ', 'Password', 'root');
      Connection.Params.Values['Port'] := Arquivo.ReadString('PROJ', 'Port', '3306');
      Connection.Connected := True;
      if Connection.Connected then
        TentarCriarDatabase;

      Connection.Connected := False;
      Connection.Params.Values['Database'] := Arquivo.ReadString('PROJ', 'Database', 'delphitec');
      Connection.Connected := True;
      if Connection.Connected then
        TentarCriarTabelasERegistros;
    except
      on E: Exception do
        ShowMessage('Erro ao se conectar ao banco de dados! Detalhes: '+e.Message);
    end;
  finally
    FreeAndNil(Arquivo);
  end;
end;

procedure TfmDM.TentarCriarDatabase;
begin
  tbAux.SQL.Clear;
  tbAux.SQL.Text := 'CREATE DATABASE IF NOT EXISTS delphitec';
  tbAux.ExecSQL;
end;

procedure TfmDM.TentarCriarTabelasERegistros;
begin
  ExecutaDiretoDB('START TRANSACTION');
  try
    if not TabelaExiste('categorias') then
    begin
      ExecutaDiretoDB('CREATE TABLE categorias ('+
        'categoriaId int AUTO_INCREMENT NOT NULL,'+
        'categoriaDescricao  varchar(30) NULL,'+
        'PRIMARY KEY (categoriaId)'+
        '	) '
      );

      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste1'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste2'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste3'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste4'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste5'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste6'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste7'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste8'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste9'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste10'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste11'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste12'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste13'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste14'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste15'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste16'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste17'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste18'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste19'')');
      ExecutaDiretoDB('INSERT INTO categorias(categoriaDescricao) VALUES (''CategoriaTeste20'')');
    end;
    if not TabelaExiste('produtos') then
    begin
      ExecutaDiretoDB('CREATE TABLE produtos( '+
        ' produtoId int AUTO_INCREMENT NOT NULL, '+
        ' produtoNome varchar(60) NULL, '+
        ' produtoDescricao varchar(255) null, '+
        ' produtoValor decimal(18,5) default 0 null, '+
        ' produtoQuantidade int DEFAULT 0 NULL, '+
        ' categoriaId int null, '+
        ' PRIMARY KEY (produtoId), '+
        ' CONSTRAINT FK_ProdutosCategorias '+
        ' FOREIGN KEY (categoriaId) references categorias(categoriaId) '+
        '	) '
      );

      ExecutaDiretoDB('INSERT INTO produtos(produtoNome, produtoDescricao, produtoValor, produtoQuantidade, categoriaId) VALUES (''ProdutoTeste1'', ''Produto Teste 1'', 100, 1, 1)');
      ExecutaDiretoDB('INSERT INTO produtos(produtoNome, produtoDescricao, produtoValor, produtoQuantidade, categoriaId) VALUES (''ProdutoTeste2'', ''Produto Teste 2'', 100, 1, 2)');
      ExecutaDiretoDB('INSERT INTO produtos(produtoNome, produtoDescricao, produtoValor, produtoQuantidade, categoriaId) VALUES (''ProdutoTeste3'', ''Produto Teste 3'', 100, 1, 3)');
      ExecutaDiretoDB('INSERT INTO produtos(produtoNome, produtoDescricao, produtoValor, produtoQuantidade, categoriaId) VALUES (''ProdutoTeste4'', ''Produto Teste 4'', 100, 1, 4)');
      ExecutaDiretoDB('INSERT INTO produtos(produtoNome, produtoDescricao, produtoValor, produtoQuantidade, categoriaId) VALUES (''ProdutoTeste5'', ''Produto Teste 5'', 100, 1, 5)');
      ExecutaDiretoDB('INSERT INTO produtos(produtoNome, produtoDescricao, produtoValor, produtoQuantidade, categoriaId) VALUES (''ProdutoTeste6'', ''Produto Teste 6'', 100, 1, 6)');
      ExecutaDiretoDB('INSERT INTO produtos(produtoNome, produtoDescricao, produtoValor, produtoQuantidade, categoriaId) VALUES (''ProdutoTeste7'', ''Produto Teste 7'', 100, 1, 7)');
      ExecutaDiretoDB('INSERT INTO produtos(produtoNome, produtoDescricao, produtoValor, produtoQuantidade, categoriaId) VALUES (''ProdutoTeste8'', ''Produto Teste 8'', 100, 1, 8)');
      ExecutaDiretoDB('INSERT INTO produtos(produtoNome, produtoDescricao, produtoValor, produtoQuantidade, categoriaId) VALUES (''ProdutoTeste9'', ''Produto Teste 9'', 100, 1, 9)');
      ExecutaDiretoDB('INSERT INTO produtos(produtoNome, produtoDescricao, produtoValor, produtoQuantidade, categoriaId) VALUES (''ProdutoTeste10'', ''Produto Teste 10'', 100, 1, 10)');
    end;

    if not TabelaExiste('clientes') then
    begin
      ExecutaDiretoDB('CREATE TABLE IF NOT EXISTS clientes('+
         'clienteId int AUTO_INCREMENT NOT NULL, '+
         'clienteNome varchar(60) NULL, '+
         'clienteCidade varchar(50) null, '+
         'clienteUF varchar(2) NULL, '+
         'PRIMARY KEY (clienteId) '+
         '	) '
      );

      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste1'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste2'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste3'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste4'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste5'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste6'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste7'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste8'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste9'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste10'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste11'', ''CidadeTeste'', ''UF'')');
      ExecutaDiretoDB('INSERT INTO clientes(clienteNome, clienteCidade, clienteUF) VALUES (''ClienteTeste12'', ''CidadeTeste'', ''UF'')');
    end;

    if not TabelaExiste('vendas') then
    begin
      ExecutaDiretoDB('CREATE TABLE IF NOT EXISTS vendas('+
         ' vendaId int AUTO_INCREMENT not null, '+
         ' clienteId int not null, '+
         ' dataVenda datetime, '+
         ' totalVenda decimal(18,5) DEFAULT 0, '+
         ' PRIMARY KEY (vendaId), '+
         ' CONSTRAINT FK_VendasClientes FOREIGN KEY (clienteId)'+
         ' REFERENCES clientes(clienteId)'+
         '	) '
       );
    end;

    if not TabelaExiste('vendasitens') then
    begin
      ExecutaDiretoDB('CREATE TABLE IF NOT EXISTS vendasitens( '+
        ' vendaId int AUTO_INCREMENT NOT NULL, '+
        ' produtoId int not null, '+
        ' itensValorUnitario decimal (18,5) default 0.00000, '+
        ' itensQuantidade decimal (18,5) default 0.00000, '+
        ' itensTotalProduto decimal (18,5) default 0.00000, '+
        ' PRIMARY KEY (vendaId,produtoId), '+
        ' CONSTRAINT FK_VendasItensProdutos FOREIGN KEY (produtoId) '+
        ' REFERENCES produtos(produtoId)'+
        '	) '
      );
    end;
    ExecutaDiretoDB('COMMIT');
  except
    ExecutaDiretoDB('ROLLBACK');
    ShowMessage('Não foi possivel realizar adição de tabelas e registros');
    Application.Terminate;
  end;
end;

function TfmDM.TabelaExiste(aNomeTabela: String): Boolean;
Begin
  Try
    Result := False;
    tbAux.SQL.Clear;
    tbAux.SQL.Text :=
      ' SELECT COUNT(*) ' +
        ' FROM information_schema.tables ' +
        ' WHERE table_schema = ''delphitec'' ' +
        ' AND table_name=:NomeTabela ';
    tbAux.ParamByName('NomeTabela').AsString := aNomeTabela;
    tbAux.Open;
    Result := tbAux.Fields[0].AsInteger > 0;
  Finally
    tbAux.Close;
  End;
end;

procedure TfmDM.ExecutaDiretoDB(aScript : String);
begin
  tbAux.SQL.Clear;
  tbAux.SQL.Add(aScript);
  tbAux.ExecSQL;
end;

end.
