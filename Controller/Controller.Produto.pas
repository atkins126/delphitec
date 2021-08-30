unit Controller.Produto;

interface

uses
  System.Generics.Collections, System.Sysutils, Controller.Interfaces, Data.DB,
  FireDAC.Comp.Client, Model.Interfaces, Model.Produto, DAO.Interfaces;

type
  TControllerProduto = class(TInterfacedObject, IControllerProduto)
  private
    FConexao: IConexao;
  public
    procedure AfterConstruction; override;
    function Selecionar(AId: Integer): IModelProduto;
  end;

implementation

procedure TControllerProduto.AfterConstruction;
begin
  inherited;
  FConexao := CreateConnection;
end;

function TControllerProduto.Selecionar(AId: Integer): IModelProduto;
var
  ProdutoDS: TFDQuery;
begin
  Result := nil;
  ProdutoDS := TFDQuery.Create(nil);
  if FConexao.AbreTabela(
              'SELECT produtoId,'+
              '       produtoNome, '+
              '       produtoDescricao, '+
              '       produtoValor, '+
              '       produtoQuantidade, '+
              '       categoriaId '+
              '  FROM produtos '+
              ' WHERE produtoId=' + AId.ToString, ProdutoDS) then
  begin
    Result := TModelProduto.Create;
    Try
      Result.produtoId     := ProdutoDS.FieldByName('produtoId').AsInteger;
      Result.produtoNome          := ProdutoDS.FieldByName('produtoNome').AsString;
      Result.produtoDescricao     := ProdutoDS.FieldByName('produtoDescricao').AsString;
      Result.produtoValor         := ProdutoDS.FieldByName('produtoValor').AsFloat;
      Result.produtoQuantidade    := ProdutoDS.FieldByName('produtoQuantidade').AsInteger;
      Result.categoriaId   := ProdutoDS.FieldByName('categoriaId').AsInteger;
    Except
      Result := nil;
    End;
  end;
end;

end.
