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
  UfrmBotaoCancelar, Vcl.ExtCtrls, System.Generics.Collections, UpessoaDao;

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
  private
    { Private declarations }
     procedure ExibirFormCadastroClientes();
     procedure ListarPessoas();
  public
    { Public declarations }

    const LTipoPessoa : Char = 'C';
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
//var
//  LItem: TListItem;
begin
//  LItem := lvwClientes.Items.Add();
//  LItem.Caption := 'Marcio';
//  LItem.SubItems.Add('2134234324');
//  LItem.SubItems.Add('(47)9925645663');
//  LItem.SubItems.Add('Ativo');
  Self.ExibirFormCadastroClientes;
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
    LItem.Caption := LPessoa.nome;
    LItem.SubItems.Add(LPessoa.cpf);
    LItem.SubItems.Add(LPessoa.telefone.ToString);
    LItem.SubItems.Add(LPessoa.ativo.ToString);
    FreeAndNil(LPessoa);
  end;
  FreeAndNil(LListaPessoas);
  FreeAndNil(LDao);
end;

end.
