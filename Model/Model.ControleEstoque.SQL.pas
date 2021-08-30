unit Model.ControleEstoque.SQL;

interface

uses
  Data.DB, DAO.Interfaces, FireDAC.Comp.Client, Model.Interfaces;

type
  TModelControleEstoque = class(TInterfacedObject, IModelEstoque)
   private
    F_produtoId: Integer;
    F_produtoQuantidade: Double;
    function GetProdutoId: Integer;
    procedure SetProdutoId(const Value: Integer);
    function GetProdutoQuantidade: Double;
    procedure SetProdutoQuantidade(const Value: Double);
  published
    property produtoId: Integer read F_produtoId write F_produtoId;
    property produtoQuantidade: Double read F_produtoQuantidade write F_produtoQuantidade;
  end;

implementation

uses
  System.SysUtils;

{ TModelControleEstoque }

function TModelControleEstoque.GetProdutoId: Integer;
begin
  Result := F_produtoId;
end;

procedure TModelControleEstoque.SetProdutoId(const Value: Integer);
begin
  F_produtoId := Value;
end;

procedure TModelControleEstoque.SetProdutoQuantidade(const Value: Double);
begin
  F_produtoQuantidade := Value;
end;

function TModelControleEstoque.GetProdutoQuantidade: Double;
begin
  Result := F_produtoQuantidade;
end;

end.
