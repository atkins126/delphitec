program proj_DelphiTec;

uses
  Vcl.Forms,
  View.Principal in 'View.Principal.pas' {frmPrincipal},
  Controller.Interfaces in '..\Controller\Controller.Interfaces.pas',
  Model.Interfaces in '..\Model\Model.Interfaces.pas',
  View.ScreenControl.Principal in 'View.ScreenControl.Principal.pas',
  View.Interfaces in 'View.Interfaces.pas',
  Model.Vendas in '..\Model\Model.Vendas.pas',
  Model.ControleEstoque.SQL in '..\Model\Model.ControleEstoque.SQL.pas',
  Model.Produto in '..\Model\Model.Produto.pas',
  DMConexao in 'DMConexao.pas' {fmDM: TDataModule},
  Controller.Vendas in '..\Controller\Controller.Vendas.pas',
  DAO.Classes in '..\DAO\DAO.Classes.pas',
  DAO.Interfaces in '..\DAO\DAO.Interfaces.pas',
  Controller.Produto in '..\Controller\Controller.Produto.pas',
  Controller.Estoque in '..\Controller\Controller.Estoque.pas',
  View.Processo.Vendas in 'View.Processo.Vendas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmDM, fmDM);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
