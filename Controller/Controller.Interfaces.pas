unit Controller.Interfaces;

interface

uses
  System.Generics.Collections, System.Sysutils, Model.Interfaces, Model.Produto,
  Model.Vendas, Data.DB, View.ScreenControl.Principal, Datasnap.DBClient;

type
  IControllerProduto = interface
    ['{C2C5DA5E-ED95-44EC-8BDF-6697BB6158E8}']
    function Selecionar(AId: Integer): IModelProduto;
  end;

  IControllerVenda = interface
    ['{EEC9747A-38FE-4243-B963-83C0418AD1B7}']
    function EsteItemExiste(vendaId, produtoId: Integer): Boolean;
    function AtualizarItem(cds: TClientDataSet; AVendaID: Integer): Boolean;
    function ApagaItens(cds:TClientDataSet; AVendaID: Integer): Boolean;
    function InserirItens(cds: TClientDataSet; IdVenda: Integer): Boolean;
    procedure RetornarEstoque(AVendaId: Integer; sCodigo: String; Acao: TAcaoExcluirEstoque);
    procedure BaixarEstoque(produtoId:Integer; Quantidade:Double);
    function VarreduraDataSet(cds: TClientDataSet): String;
    function Inserir(AVenda: IModelVenda; cds: TClientDataSet):Integer;
    function Atualizar(AVenda: IModelVenda; cds: TClientDataSet): IModelVenda;
    function Apagar(id:Integer): Boolean;
    function Selecionar(id:Integer; var cds: TClientDataSet): IModelVenda;
  end;

  IControllerEstoque = interface
    ['{11C8435D-B3D6-40CC-86F7-790C3E4D7E6D}']
    function BaixarEstoque(AEstoque: IModelEstoque): IModelEstoque;
    function RetornarEstoque(AEstoque: IModelEstoque): IModelEstoque;
  end;

implementation

end.
