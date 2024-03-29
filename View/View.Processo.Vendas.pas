unit View.Processo.Vendas;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.DBCtrls,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.Buttons,

  Data.DB,
  Vcl.Mask,
  Controller.Interfaces,
  DAO.Interfaces,
  Model.Vendas,
  FireDAC.Comp.Client,
  Controller.Vendas,
  View.ScreenControl.Principal,
  View.Formatar,

  Model.Interfaces,
  Controller.Produto,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  Datasnap.DBClient;

type
  TViewProcessoVendas = class(TForm)
    pnlFull: TPanel;
    Edit1: TEdit;
    ListBox1: TListBox;
    Button1: TButton;
    pnlLeft: TPanel;
    spbNovo: TSpeedButton;
    spbEditar: TSpeedButton;
    spbSalvar: TSpeedButton;
    spbDeletar: TSpeedButton;
    spbCancelar: TSpeedButton;
    Panel1: TPanel;
    imgLogo: TImage;
    lblIndice: TLabel;
    spbPesquisar: TSpeedButton;
    pnlRight: TPanel;
    pgcVendas: TPageControl;
    tabConsulta: TTabSheet;
    grdVendas: TDBGrid;
    tabCadastro: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    spbAdicionarProduto: TSpeedButton;
    spbRemoverProduto: TSpeedButton;
    edtVendaId: TLabeledEdit;
    lkpCliente: TDBLookupComboBox;
    lkpProduto: TDBLookupComboBox;
    pnlVenda: TPanel;
    pnlTotalizador: TPanel;
    Label2: TLabel;
    grdItensVenda: TDBGrid;
    pnlBottom: TPanel;
    spbFecharTela: TSpeedButton;
    mskPesquisa: TMaskEdit;
    dsVendas: TDataSource;
    tbVendas: TFDQuery;
    dsItens: TDataSource;
    tbItens: TClientDataSet;
    tbItensprodutoId: TIntegerField;
    tbItensprodutoNome: TStringField;
    tbItensprodutoQuantidade: TFloatField;
    tbItensprodutoValorUnitario: TFloatField;
    tbItensprodutoValorTotal: TFloatField;
    tbClientes: TFDQuery;
    dsClientes: TDataSource;
    tbProdutos: TFDQuery;
    dsProdutos: TDataSource;
    edtQuantidade: TEdit;
    edtTotalProduto: TEdit;
    edtDataVenda: TEdit;
    edtValorTotal: TEdit;
    edtValorUnitario: TEdit;
    procedure edtQuantidadeExit(Sender: TObject);
    procedure grdItensVendaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdVendasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdItensVendaDblClick(Sender: TObject);
    procedure spbFecharTelaClick(Sender: TObject);
    procedure spbEditarClick(Sender: TObject);
    procedure spbCancelarClick(Sender: TObject);
    procedure spbPesquisarClick(Sender: TObject);
    procedure grdVendasTitleClick(Column: TColumn);
    procedure grdVendasDblClick(Sender: TObject);
    procedure spbSalvarClick(Sender: TObject);
    procedure spbDeletarClick(Sender: TObject);
    procedure spbRemoverProdutoClick(Sender: TObject);
    procedure spbAdicionarProdutoClick(Sender: TObject);
    procedure spbNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabCadastroShow(Sender: TObject);
    procedure lkpProdutoExit(Sender: TObject);
    procedure edtDataVendaChange(Sender: TObject);
    procedure edtTotalProdutoChange(Sender: TObject);
    procedure edtValorUnitarioChange(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure edtValorUnitarioExit(Sender: TObject);
  private
    Operacao: TOperacao;
    FControllerVenda : IControllerVenda;
    FConexao : IConexao;
    IndiceAtual:string;
    SelectOriginal:String;
    procedure Editar(FOperacao : TOperacao);
    procedure Novo(Operacao: TOperacao);
    function Gravar(Operacao: TOperacao): Boolean;
    function Apagar: Boolean;
    procedure AdicionarItem;
    procedure LimparComponenteItem;
    procedure LimparCds;
    function TotalizarVenda: Double;
    procedure CarregarRegistroSelecionado;
    function TotalizarProduto(valorUnitario, Quantidade: Double): Double;
    procedure BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
      btnApagar: TSpeedButton; pgcPrincipal: TPageControl; Flag: Boolean);
    procedure ControlaIndiceTab(pgcVendas:TPageControl; i: Integer);
    function ExisteCampoObrigatorio: Boolean;
    function RetornarCampoTraduzido(Campo: string): string;
    procedure DesabilitarEditPK;
    procedure LimparEdits;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    procedure ConfigurarCamposVendas;
    procedure NomeiaTituloVendasGrid;
    procedure ConfigurarCamposProdutos;
    procedure NomeiaTituloProdutosGrid;
    procedure mskPesquisaChange(Sender: TObject);
    function TratarValor(AValor: String): Extended;
  public
  end;

var
  ViewProcessoVendas: TViewProcessoVendas;

implementation

{$R *.dfm}

uses
  Model.Produto, System.StrUtils;

procedure TViewProcessoVendas.grdItensVendaDblClick(Sender: TObject);
begin
  CarregarRegistroSelecionado;
end;

procedure TViewProcessoVendas.grdItensVendaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  BloqueiaCTRL_DEL_DBGrid(key, shift);
end;

procedure TViewProcessoVendas.Editar(FOperacao : TOperacao);
var
  FVenda: IModelVenda;
begin
  FVenda := FControllerVenda.Selecionar(tbVendas.FieldByName('vendaId').AsInteger,
    tbItens);
  if Assigned(FVenda) then
  begin
    edtVendaId.Text     := IntToStr(FVenda.VendaId);
    lkpCliente.KeyValue := FVenda.clienteId;
    edtDataVenda.Text   := DateToStr(FVenda.DataVenda);
    edtValorTotal.Text := FloatToStr(FVenda.TotalVenda);
  end
  else
  begin
    spbCancelar.Click;
    Abort;
  end;
  ControlarBotoes(spbNovo, spbEditar, spbCancelar, spbSalvar,
                  spbDeletar, pgcVendas, False);
  ConfigurarCamposProdutos;
  NomeiaTituloProdutosGrid;
end;

procedure TViewProcessoVendas.mskPesquisaChange(Sender: TObject);
begin
  tbVendas.Locate(IndiceAtual, TMaskEdit(Sender).Text,[loPartialKey])
end;


procedure TViewProcessoVendas.edtDataVendaChange(Sender: TObject);
begin
  Formatar(edtDataVenda, Dt);
end;

procedure TViewProcessoVendas.edtQuantidadeChange(Sender: TObject);
begin
  //Formatar(edtQuantidade, Valor);
end;

procedure TViewProcessoVendas.edtQuantidadeExit(Sender: TObject);
begin
  edtTotalProduto.Text := FormatFloat('#,##0.00',
    TotalizarProduto(TratarValor(edtValorUnitario.Text), StrToFloat(edtQuantidade.Text)));
end;

procedure TViewProcessoVendas.edtTotalProdutoChange(Sender: TObject);
begin
  //Formatar(edtTotalProduto, Valor);
end;

procedure TViewProcessoVendas.edtValorUnitarioChange(Sender: TObject);
begin
  Formatar(edtValorUnitario, Valor);
end;

procedure TViewProcessoVendas.edtValorUnitarioExit(Sender: TObject);
begin
  edtTotalProduto.Text := FormatFloat('#,##0.00', TotalizarProduto(TratarValor(edtValorUnitario.Text),
    StrToFloat(edtQuantidade.Text)));
end;

procedure TViewProcessoVendas.ExibirLabelIndice(Campo: string; aLabel:TLabel);
begin
  aLabel.Caption:=RetornarCampoTraduzido(Campo);
end;

procedure TViewProcessoVendas.FormCreate(Sender: TObject);
begin
  tbItens.CreateDataSet;
  FConexao := CreateConnection;
  FControllerVenda := TControllerVenda.Create;
  ControlarBotoes(spbNovo, spbEditar, spbCancelar, spbSalvar, spbDeletar, pgcVendas, true);
  grdVendas.Options := [dgTitles,
                        dgIndicator,
                        dgColumnResize,
                        dgColLines,
                        dgRowLines,
                        dgTabs,
                        dgRowSelect,
                        dgAlwaysShowSelection,
                        dgCancelOnExit,
                        dgTitleClick,
                        dgTitleHotTrack];
end;

procedure TViewProcessoVendas.FormShow(Sender: TObject);
begin
  ControlaIndiceTab(pgcVendas, 0);
  lblIndice.Caption := IndiceAtual;
  DesabilitarEditPK;
  if tbVendas.SQL.Text <> EmptyStr then
  begin
    tbVendas.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual, lblIndice);
    SelectOriginal := tbVendas.SQL.Text;
    FConexao.AbreTabela(
      'SELECT ' +
        'vendas.vendaId, ' +
        'vendas.clienteId, ' +
        'clientes.clienteNome, ' +
        'vendas.dataVenda, ' +
        'vendas.totalVenda ' +
      'FROM ' +
        'vendas ' +
        'INNER JOIN clientes ON clientes.clienteId = vendas.clienteId ', tbVendas);

    FConexao.AbreTabela('SELECT clienteId, '+
                        'clienteNome '+
                        'FROM clientes', tbClientes);
  end;
  ConfigurarCamposVendas;
  NomeiaTituloVendasGrid;
  Operacao := opNenhum;
end;

procedure TViewProcessoVendas.ControlaIndiceTab(pgcVendas:TPageControl; i: Integer);
begin
  if (pgcVendas.Pages[i].TabVisible) then
      pgcVendas.TabIndex:=0;
end;

procedure TViewProcessoVendas.spbAdicionarProdutoClick(Sender: TObject);
var
  FModelProduto : TModelProduto;
begin
  if lkpProduto.KeyValue = Null then
  begin
    MessageDlg('Produto � um campo obrigat�rio' ,mtInformation,[mbOK],0);
    lkpProduto.SetFocus;
    abort;
  end;

  if TratarValor(edtValorUnitario.Text) <= 0 then
  begin
    MessageDlg('Valor Unit�rio n�o pode ser Zero' ,mtInformation,[mbOK],0);
    edtValorUnitario.SetFocus;
    abort;
  end;

  if edtQuantidade.Text <= '0' then
  begin
    MessageDlg('Quantidade n�o pode ser Zero' ,mtInformation,[mbOK],0);
    edtQuantidade.SetFocus;
    abort;
  end;

  edtTotalProduto.Text := FormatFloat('#,##0.00', TotalizarProduto(TratarValor(edtValorUnitario.Text), StrToFloat(edtQuantidade.Text)));

  tbItens.Append;
  tbItens.FieldByName('produtoId').AsString := lkpProduto.KeyValue;
  tbItens.FieldByName('produtoNome').AsString := tbProdutos.FieldByName('produtoNome').AsString;
  tbItens.FieldByName('produtoQuantidade').AsFloat := StrToFloat(edtQuantidade.Text);
  tbItens.FieldByName('produtoValorUnitario').AsFloat := TratarValor(edtValorUnitario.Text);
  tbItens.FieldByName('produtoValorTotal').AsFloat := TratarValor(edtTotalProduto.Text);
  tbItens.Post;
  edtValorTotal.Text := FloatToStr(TotalizarVenda);
  LimparComponenteItem;
  lkpProduto.SetFocus;
end;

procedure TViewProcessoVendas.spbCancelarClick(Sender: TObject);
var
  FOperacao : TOperacao;
begin
  ControlarBotoes(spbNovo, spbEditar, spbCancelar, spbSalvar, spbDeletar, pgcVendas, true);
  ControlaIndiceTab(pgcVendas, 0);
  FOperacao := opNenhum;
  LimparEdits;
  LimparCds;
  Operacao := opNenhum;
end;

procedure TViewProcessoVendas.spbDeletarClick(Sender: TObject);
var
  FOperacao : TOperacao;
begin
   try
    if (Apagar) then
    begin
       ControlarBotoes(spbNovo, spbEditar, spbCancelar, spbSalvar, spbDeletar, pgcVendas, true);
       ControlaIndiceTab(pgcVendas, 0);
       LimparEdits;
       tbVendas.Refresh;
    end
    else begin
      MessageDlg('Erro ao Gravar', mtWarning,[mbOK],0);
    end;
  finally
    FOperacao := opNenhum;
  end;
end;

procedure TViewProcessoVendas.spbEditarClick(Sender: TObject);
begin
  Operacao := opAlterar;
  Editar(Operacao);
end;

procedure TViewProcessoVendas.spbFecharTelaClick(Sender: TObject);
begin
  Close;
end;

procedure TViewProcessoVendas.spbNovoClick(Sender: TObject);
begin
  Operacao := opNovo;
  Novo(Operacao);
end;

procedure TViewProcessoVendas.spbPesquisarClick(Sender: TObject);
var i:Integer;
    TipoCampo:TFieldType;
    NomeCampo:String;
    WhereOrAnd:String;
    CondicaoSQL:String;
begin
   if mskPesquisa.Text='' then
  begin
    tbVendas.Close;
    tbVendas.SQL.Clear;
    tbVendas.SQL.Add(SelectOriginal);
    tbVendas.Open;
    Abort;
  end;

  //Localiza o Tipo do Campo
  for I := 0 to tbVendas.FieldCount-1 do
  begin
    if tbVendas.Fields[i].FieldName=IndiceAtual then
    begin
      TipoCampo := tbVendas.Fields[i].DataType;
      if tbVendas.Fields[i].Origin<>'' then
      begin
        if Pos('.', tbVendas.Fields[i].Origin) > 0 then
          NomeCampo := tbVendas.Fields[i].Origin
        else
          NomeCampo := tbVendas.Fields[i].Origin+'.'+tbVendas.Fields[i].FieldName
      end
      else
        NomeCampo := tbVendas.Fields[i].FieldName;

      Break;
    end;
  end;

  //Verifica se ir� utilizar o Where ou And
  if Pos('where',LowerCase(SelectOriginal)) > 1 then
  begin
    WhereOrAnd := ' and '
  end
  else
  begin
    WhereOrAnd := ' where ';
  end;

  if (TipoCampo=ftString) or (TipoCampo=ftWideString) then
  begin
     CondicaoSQL := WhereOrAnd+' '+ NomeCampo + ' LIKE '+QuotedStr('%'+mskPesquisa.Text+'%');
  end
  else if (TipoCampo = ftInteger) or (TipoCampo = ftSmallint) then
  begin
     CondicaoSQL := WhereOrAnd+' '+NomeCampo + '='+mskPesquisa.Text
  end
  else if (TipoCampo = ftFloat) or (TipoCampo=ftCurrency) then
  begin
     CondicaoSQL := WhereOrAnd+' '+NomeCampo + '='+StringReplace(mskPesquisa.Text,',','.',[rfReplaceAll]);
  end
  else if (TipoCampo = ftDate) or (TipoCampo = ftDateTime) then
  begin
     CondicaoSQL := WhereOrAnd+' '+NomeCampo + '='+QuotedStr(mskPesquisa.Text)
  end;

  tbVendas.Close;
  tbVendas.SQL.Clear;
  tbVendas.SQL.Add(SelectOriginal);
  tbVendas.SQL.Add(CondicaoSQL);
  tbVendas.Open;

  mskPesquisa.Text := '';
end;

procedure TViewProcessoVendas.spbRemoverProdutoClick(Sender: TObject);
begin
  if tbItens.FieldByName('produtoID').AsInteger <= 0 then
  begin
    MessageDlg('Selecione o Produto a ser exclu�do' ,mtInformation,[mbOK],0);
    grdItensVenda.SetFocus;
    abort;
  end;

  tbItens.Delete;
  LimparComponenteItem;

  edtValorTotal.Text := FloatToStr(TotalizarVenda);
end;

procedure TViewProcessoVendas.spbSalvarClick(Sender: TObject);
begin
  if ExisteCampoObrigatorio then
     Abort;
  Try
    if Gravar(Operacao) then
    begin
      ControlarBotoes(spbNovo, spbEditar, spbCancelar, spbSalvar, spbDeletar, pgcVendas, true);
      ControlaIndiceTab(pgcVendas, 0);
      LimparEdits;
      tbVendas.Refresh;
    end
    else
      MessageDlg('Erro ao Gravar', mtWarning, [mbOK], 0);
  Finally
    Operacao := opNenhum;
  End;
  LimparCds;
end;

procedure TViewProcessoVendas.tabCadastroShow(Sender: TObject);
begin
  FConexao.AbreTabela('SELECT produtoId,'+
              '       produtoNome, '+
              '       produtoDescricao, '+
              '       produtoValor, '+
              '       produtoQuantidade, '+
              '       categoriaId '+
              '  FROM produtos', tbProdutos);
end;

function TViewProcessoVendas.Gravar(Operacao : TOperacao): Boolean;
var
  FVenda: IModelVenda;
begin
  Result := False;
  if (Operacao = opNovo) then
  begin
    FVenda := TModelVendas.Create;
    if edtVendaId.Text <> EmptyStr then
       FVenda.VendaId := StrToInt(edtVendaId.Text)
    else
       FVenda.VendaId := 0;

    FVenda.ClienteId := lkpCliente.KeyValue;
    FVenda.DataVenda := StrToDate(edtDataVenda.Text);
    FVenda.TotalVenda := StrToFloat(edtValorTotal.Text);

    FVenda.VendaId := FControllerVenda.Inserir(FVenda, tbItens);
  end
  else if (Operacao = opAlterar) then
  begin
    FVenda := FControllerVenda.Selecionar(tbVendas.FieldByName('vendaID').AsInteger, tbItens);

    FVenda.ClienteId := lkpCliente.KeyValue;
    FVenda.DataVenda := StrToDate(edtDataVenda.Text);
    FVenda.TotalVenda := StrToFloat(edtValorTotal.Text);

    FVenda := FControllerVenda.Atualizar(FVenda, tbItens);
  end;
  Result := FVenda.VendaId > 0;
  Operacao := opNenhum;
end;

procedure TViewProcessoVendas.grdVendasDblClick(Sender: TObject);
begin
  spbEditar.Click;
end;

procedure TViewProcessoVendas.grdVendasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  BloqueiaCTRL_DEL_DBGrid(key, shift);


  if Key = VK_RETURN then
    spbEditar.Click;

  if Key = VK_DELETE then
    spbDeletar.Click;
end;

procedure TViewProcessoVendas.grdVendasTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  tbVendas.IndexFieldNames := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

function TViewProcessoVendas.Apagar: Boolean;
begin
  if MessageDlg('Apagar o Registro: ' + #13 + #13 + 'Venda Nr�: ' +
    IntToStr(tbVendas.FieldByName('vendaId').AsInteger),
    mtConfirmation, [mbYes, mbNo], 0, mbNo) = mrNo then
  begin
    Result := False;
    abort;
  end;

  Result := FControllerVenda.Apagar(tbVendas.FieldByName('vendaId').AsInteger);
end;

procedure TViewProcessoVendas.AdicionarItem;
begin
  if lkpProduto.KeyValue=Null then
  begin
     MessageDlg('Produto � um campo obrigat�rio' ,mtInformation,[mbOK],0);
     lkpProduto.SetFocus;
     abort;
  end;

  if TratarValor(edtValorUnitario.Text) <= 0 then
  begin
     MessageDlg('Valor Unit�rio n�o pode ser Zero' ,mtInformation,[mbOK],0);
     edtValorUnitario.SetFocus;
     abort;
  end;

  if edtQuantidade.Text <= '0' then
  begin
     MessageDlg('Quantidade n�o pode ser Zero' ,mtInformation,[mbOK],0);
     edtQuantidade.SetFocus;
     abort;
  end;

  if tbItens.Locate('produtoId', lkpProduto.KeyValue, []) then
  begin
     MessageDlg('Este Produto j� foi selecionado' ,mtInformation,[mbOK],0);
     lkpProduto.SetFocus;
     abort;
  end;

  edtTotalProduto.Text := FormatFloat('#,##0.00', TotalizarProduto(TratarValor(edtValorUnitario.Text), StrToFloat(edtQuantidade.Text)));

  tbItens.Append;
  tbItens.FieldByName('produtoId').AsString := lkpProduto.KeyValue;
  tbItens.FieldByName('produtoNome').AsString := tbProdutos.FieldByName('produtoNome').AsString;
  tbItens.FieldByName('produtoQuantidade').AsFloat := StrToFloat(edtQuantidade.Text);
  tbItens.FieldByName('produtoValorUnitario').AsFloat := TratarValor(edtValorUnitario.Text);
  tbItens.FieldByName('produtoValorTotal').AsFloat := TratarValor(edtTotalProduto.Text);
  tbItens.Post;
  edtValorTotal.Text := FloatToStr(TotalizarVenda);
  LimparComponenteItem;
  lkpProduto.SetFocus;
end;

procedure TViewProcessoVendas.LimparComponenteItem;
begin
  lkpProduto.KeyValue   := null;
  edtQuantidade.Text := '0';
  edtValorUnitario.Text := '0';
  edtTotalProduto.Text := '0';
end;

procedure TViewProcessoVendas.LimparCds;
begin
  tbItens.EmptyDataSet;
end;

function TViewProcessoVendas.TotalizarVenda:Double;
begin
  result:=0;
  tbItens.First;
  while not tbItens.Eof do
  begin
    result := result + tbItens.FieldByName('produtoValorTotal').AsFloat;
    tbItens.Next;
  end;
end;

function TViewProcessoVendas.TratarValor(AValor: String): Extended;
begin
  Result := StrToFloat(ReplaceText(Trim(AValor), '.', ''));
end;

procedure TViewProcessoVendas.CarregarRegistroSelecionado;
begin
  lkpProduto.KeyValue   := tbItens.FieldByName('produtoId').AsString;
  edtQuantidade.Text := tbItens.FieldByName('produtoQuantidade').AsString;
  edtValorUnitario.Text := FormatFloat('#,##0.00', tbItens.FieldByName('produtoValorUnitario').AsFloat);
  edtTotalProduto.Text := FormatFloat('#,##0.00', tbItens.FieldByName('produtoValorTotal').AsFloat);
end;

function TViewProcessoVendas.TotalizarProduto(valorUnitario, Quantidade:Double):Double;
begin
  Result := valorUnitario * Quantidade;
end;

procedure TViewProcessoVendas.BloqueiaCTRL_DEL_DBGrid(var Key: Word; Shift: TShiftState);
begin
   //Bloqueia o CTRL + DEL
   if (Shift = [ssCtrl]) and (Key = 46) then
      Key := 0;
end;

procedure TViewProcessoVendas.ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
      btnApagar: TSpeedButton; pgcPrincipal: TPageControl; Flag: Boolean);
begin
  spbNovo.Enabled      :=Flag;
  spbDeletar.Enabled    :=Flag;
  spbEditar.Enabled   :=Flag;
  pgcVendas.Pages[0].TabVisible := Flag;

  spbCancelar.Enabled  := not(Flag);
  spbSalvar.Enabled    := not(Flag);
end;

function TViewProcessoVendas.RetornarCampoTraduzido(Campo: string):string;
var i:Integer;
begin
  for I := 0 to tbVendas.FieldCount-1 do begin
    if LowerCase(tbVendas.Fields[i].FieldName) = LowerCase(Campo) then begin
       Result:=tbVendas.Fields[i].DisplayLabel;
       Break;
    end;
  end;
end;

function TViewProcessoVendas.ExisteCampoObrigatorio:Boolean;
var i:Integer;
begin
  Result:=False;
  for I := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin
       if (TLabeledEdit(Components[i]).Tag = 2) and (TLabeledEdit(Components[i]).Text = EmptyStr) then begin
          MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption + ' � um campo obrigat�rio' ,mtInformation,[mbOK],0);
          TLabeledEdit(Components[i]).SetFocus;
          Result:=True;
          Break;
       end;
    end;
  end;
end;

procedure TViewProcessoVendas.DesabilitarEditPK;
var i:Integer;
begin
  for I := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then begin
       if (TLabeledEdit(Components[i]).Tag = 1) then begin
          TLabeledEdit(Components[i]).Enabled:=false;
          Break;
       end;
    end;
  end;
end;

procedure TViewProcessoVendas.LimparEdits;
Var i:Integer;
begin
  for i := 0 to ComponentCount -1 do begin
    if (Components[i] is TLabeledEdit) then
      TLabeledEdit(Components[i]).Text:=EmptyStr
    else if (Components[i] is TEdit) then
      TEdit(Components[i]).Text:=''
    else if (Components[i] is TDBLookupComboBox) then
      TDBLookupComboBox(Components[i]).KeyValue:=Null
    else if (Components[i] is TMemo) then
      TMemo(Components[i]).Text:=''
    else if (Components[i] is TMaskEdit) then
      TMaskEdit(Components[i]).Text:='';

  end;
end;

procedure TViewProcessoVendas.lkpProdutoExit(Sender: TObject);
begin
  if lkpProduto.KeyValue <> Null then
  begin
    edtValorUnitario.Text :=
      FormatFloat('#,##0.00', tbProdutos.FieldByName('produtoValor').AsFloat);
    edtQuantidade.Text := '1';
    edtTotalProduto.Text := FormatFloat('#,##0.00', TotalizarProduto(TratarValor(edtValorUnitario.Text),
      StrToFloat(edtQuantidade.Text)));
  end;
end;

procedure TViewProcessoVendas.ConfigurarCamposVendas;
begin
  grdVendas.Columns.Add();
  grdVendas.Columns[0].FieldName := 'vendaId';
  grdVendas.Columns[0].Width := 80;

  grdVendas.Columns.Add();
  grdVendas.Columns[1].FieldName := 'clienteId';
  grdVendas.Columns[1].Width := 80;

  grdVendas.Columns.Add();
  grdVendas.Columns[2].FieldName := 'clienteNome';
  grdVendas.Columns[2].Width := 300;

  grdVendas.Columns.Add();
  grdVendas.Columns[3].FieldName := 'dataVenda';
  grdVendas.Columns[3].Width := 130;

  grdVendas.Columns.Add();
  grdVendas.Columns[4].FieldName := 'totalVenda';
  grdVendas.Columns[4].Width := 130;
end;

procedure TViewProcessoVendas.NomeiaTituloVendasGrid;
begin
  tbVendas.Fields[0].DisplayLabel := 'N�mero Venda';
  tbVendas.Fields[1].DisplayLabel := 'Cod. Cliente';
  tbVendas.Fields[2].DisplayLabel := 'Nome do Cliente';
  tbVendas.Fields[3].DisplayLabel := 'Data Venda';
  tbVendas.Fields[4].DisplayLabel := 'Total Venda';
end;

procedure TViewProcessoVendas.Novo(Operacao: TOperacao);
begin
  ControlarBotoes(spbNovo, spbEditar, spbCancelar, spbSalvar,
                  spbDeletar, pgcVendas, False);
  pgcVendas.ActivePage := tabCadastro;
  edtDataVenda.Text := DateToStr(Now);
  lkpCliente.SetFocus;
  ConfigurarCamposProdutos;
  NomeiaTituloProdutosGrid;
  LimparCds;
  LimparEdits;
end;

procedure TViewProcessoVendas.ConfigurarCamposProdutos;
begin
//  grdItensVenda.Columns.Add();
//  grdItensVenda.Columns[0].FieldName := 'produtoId';
//  grdItensVenda.Columns[0].Width := 70;
//
//  grdItensVenda.Columns.Add();
//  grdItensVenda.Columns[1].FieldName := 'produtoNome';
//  grdItensVenda.Columns[1].Width := 200;
//
//  grdItensVenda.Columns.Add();
//  grdItensVenda.Columns[2].FieldName := 'produtoDescricao';
//  grdItensVenda.Columns[2].Width := 200;
//
//  grdItensVenda.Columns.Add();
//  grdItensVenda.Columns[3].FieldName := 'produtoValor';
//  grdItensVenda.Columns[3].Width := 100;
//
//  grdItensVenda.Columns.Add();
//  grdItensVenda.Columns[4].FieldName := 'produtoQuantidade';
//  grdItensVenda.Columns[4].Width := 100;
end;

procedure TViewProcessoVendas.NomeiaTituloProdutosGrid;
begin
  tbItens.Fields[0].DisplayLabel := 'Cod. Produto';
  tbItens.Fields[1].DisplayLabel := 'Descri��o';
  tbItens.Fields[2].DisplayLabel := 'Quantidade';
  tbItens.Fields[3].DisplayLabel := 'Valor Unit�rio';
  tbItens.Fields[4].DisplayLabel := 'Valor Total';
end;

end.
