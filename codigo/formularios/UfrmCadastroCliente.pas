unit UfrmCadastroCliente;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.WinXCtrls,
  UfrmBotaoPrimario,

  UfrmBotaoExcluir,
  UfrmBotaoCancelar;

type
  TfrmCadastroCliente = class(TForm)
    pnlCadastroCliente: TPanel;
    lblCadastroCliente: TLabel;
    edtNome: TEdit;
    edtTelefone: TEdit;
    mskCpf: TMaskEdit;
    dtpDataNascimento: TDateTimePicker;
    lblInformacoesGerenciais: TfrmBotaoPrimario;
    frmBotaoCancelar: TfrmBotaoCancelar;
    frmBotaoExcluir: TfrmBotaoExcluir;
    procedure lblInformacoesGerenciaisspbBotaoPrimarioClick(Sender: TObject);
    procedure frmBotaoCancelarspbBotaoCancelarClick(Sender: TObject);
    procedure frmBotaoExcluirspbBotaoExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}

procedure TfrmCadastroCliente.frmBotaoCancelarspbBotaoCancelarClick(
  Sender: TObject);
begin
  Close();
end;

procedure TfrmCadastroCliente.frmBotaoExcluirspbBotaoExcluirClick(
  Sender: TObject);
var
  LConfirmarExclusao : Integer;
begin
  LConfirmarExclusao := MessageDlg('Realmente deseja excluir o registro', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);

  if (LConfirmarExclusao = mrYes) then
  begin
    ShowMessage('Registro Excluido com sucesso!');
    close();
  end;
end;

procedure TfrmCadastroCliente.lblInformacoesGerenciaisspbBotaoPrimarioClick(
  Sender: TObject);
begin
  ShowMessage('Cliente cadastrado com sucesso');
  close();
end;

end.
