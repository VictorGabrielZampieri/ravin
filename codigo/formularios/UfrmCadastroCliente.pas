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
  Vcl.WinXCtrls, UfrmBotaoExcluir, UfrmBotaoCancelar, UfrmBotaoPrimario,
  FireDAC.Phys.MySQLWrapper;
//  UfrmBotaoPrimario,
//
//  UfrmBotaoExcluir,
//  UfrmBotaoCancelar;

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
    procedure frmBotaoCancelarspbBotaoCancelarClick(Sender: TObject);
    procedure frmBotaoExcluirspbBotaoExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure CadastrarCliente();
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses
  UpessoaDao, Upessoa, UvalidadorPessoa;

{$R *.dfm}

procedure TfrmCadastroCliente.CadastrarCliente;
var
  LDao: TPessoaDao;
  LPessoa : TPessoa;
begin
  try
    try
      LPessoa := TPessoa.Create();
      with  LPessoa do
      begin
        nome := edtNome.Text;
        tipoPessoa := 'C';
        cpf        := mskCpf.Text;
        telefone   := StrToInt(edtTelefone.Text); ////
        dataNascimento := dtpDataNascimento.DateTime;
        email := 'teste@email';
        ativo := 1;
        criadoEm := Now();
        criadoPor := 'admin';
        alteradoEm := Now();
        alteradoPor := 'admin';
      end;

      TValidadorPessoa.Validar(LPessoa);
      LDao := TPessoaDAO.Create();
      LDao.InserirPessoa(LPessoa);

      if Assigned(LPessoa) then
    begin
    ShowMessage('Cliente cadastrado com sucesso');
      close();
    end;
    except on  E: EMySQLNativeException do
      begin
        ShowMessage('Erro ao inserir a pessoa no banco');
      end;
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
     if Assigned(LDao) then
    begin
      FreeAndNil(LDao);
    end;
    FreeAndNil(LDao);
  end;
end;

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

end.
