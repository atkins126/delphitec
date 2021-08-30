unit Controller.Conexao;

interface

uses
  Model.Conexao.Factory, Model.Conexao.Table.Firedac;

type
  TControllerConexao = class
    private
    public
      function DataSetFiredac : TModelConexaoTableFiredac;
  end;

implementation



{ TControllerConexao }

function TControllerConexao.DataSetFiredac: TModelConexaoTableFiredac;
begin
  Result := TModelConexaoFactory.Create.New.Conexao;
end;

end.
