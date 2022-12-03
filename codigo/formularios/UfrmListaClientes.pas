unit UfrmListaClientes;

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
  Vcl.ComCtrls,
  Vcl.StdCtrls,

  UfrmBotaoPrimario,
  UfrmBotaoCancelar, Vcl.ExtCtrls, System.Generics.Collections, UpessoaDao,
  UiniUtils;

type
  TfrmListaClientes = class(TForm)
    frmBotaoPrimario: TfrmBotaoPrimario;
    frmBotaoCancelar: TfrmBotaoCancelar;
    lvwClientes: TListView;
    Shape1: TShape;
    Shape2: TShape;
    Shape5: TShape;
    lblInformacoesGerenciais: TLabel;
    pnlListaClientes: TPanel;
    lblListaClientesTitulo: TLabel;
    procedure frmBotaoPrimariospbBotaoPrimarioClick(Sender: TObject);
    procedure frmBotaoCancelarspbBotaoCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvwClientesSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
  private
    { Private declarations }
     procedure GravarIdPessoaIni(PCpf : String);
     procedure ExibirFormCadastroClientes();
     procedure ListarPessoas();
  public
    { Public declarations }

    const LTipoPessoa : Char = 'C';
    const LPosiscaoColunaCpf  : Integer = 1;
  end;

var
  frmListaClientes: TfrmListaClientes;

implementation

uses
  UformsUtils, UfrmCadastroCliente, Upessoa;

{$R *.dfm}

procedure TfrmListaClientes.ExibirFormCadastroClientes;
begin
  TFormsUtils.ShowForm(frmCadastroCliente, TfrmCadastroCliente);
end;

procedure TfrmListaClientes.FormShow(Sender: TObject);
begin
 ListarPessoas;
end;

procedure TfrmListaClientes.frmBotaoCancelarspbBotaoCancelarClick(
  Sender: TObject);
begin
  Close();
end;

procedure TfrmListaClientes.frmBotaoPrimariospbBotaoPrimarioClick
  (Sender: TObject);
begin
  Self.ExibirFormCadastroClientes;
end;

procedure TfrmListaClientes.GravarIdPessoaIni(PCpf: String);
var
  LId : Integer;
  LDao : TPessoaDAO;
begin
  try
    LDao := TPessoaDAO.Create();
    LId  := LDao.BuscarIdPessoaPorCpf(PCpf);
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.IDCliente, LId.ToString);
  finally
    FreeAndNil(LDao);
  end;
end;

procedure TfrmListaClientes.ListarPessoas;
var
  LDao : TPessoaDAO;
  I : Integer;
  LPessoa : TPessoa;
  LItem : TListItem;
  LListaPessoas : TList<TPessoa>;
begin
  LDao := TPessoaDAO.Create();
  LListaPessoas := LDao.BuscarTodasPessoas(LTipoPessoa);

  for I := 0 to LListaPessoas.Count -1 do
  begin
    LPessoa := LListaPessoas.Items[I];
    LItem   := lvwClientes.Items.Add();
    LItem.Caption := LPessoa.nome;
    LItem.SubItems.Add(LPessoa.cpf);
    LItem.SubItems.Add(LPessoa.telefone.ToString);
    LItem.SubItems.Add(LPessoa.ativo.ToString);
    FreeAndNil(LPessoa);
  end;
  FreeAndNil(LListaPessoas);
  FreeAndNil(LDao);
end;

procedure TfrmListaClientes.lvwClientesSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  GravarIdPessoaIni(Item.SubItems[LPosiscaoColunaCpf]);
  ExibirFormCadastroClientes();
end;

end.
