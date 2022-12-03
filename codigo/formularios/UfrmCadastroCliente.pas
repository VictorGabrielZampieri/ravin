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
    procedure lblInformacoesGerenciaisspbBotaoPrimarioClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ExibirForm();
    procedure CadastrarCliente();
    procedure ExcluirCliente();
  public
    { Public declarations }

    const Valor_Zero : Integer = 0;
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

uses
  UpessoaDao, Upessoa, UvalidadorPessoa, UiniUtils;

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
        ativo := True;
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

procedure TfrmCadastroCliente.ExcluirCliente;
var
  LConfirmarExclusao : Integer;
  LDao : TPessoaDAO;
begin
  LConfirmarExclusao := MessageDlg('Realmente deseja excluir o registro', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0);

  if (LConfirmarExclusao = mrYes) then
  begin
    ShowMessage('Registro Excluido com sucesso!');
    close();
  end;
end;

procedure TfrmCadastroCliente.ExibirForm;
var
  LId : Integer;
  LPessoa : TPessoa;
  LDao : TPessoaDAO;
begin
  try
    LId := StrToInt(TIniUtils.lerPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.IDCliente));
    if not(LId = Valor_Zero) then
    begin
      LDao := TPessoaDAO.Create();
      LPessoa := LDao.BuscarPessoaPorId(LId);
    end;
    if Assigned(LPessoa) then
    begin
      edtNome.Text := LPessoa.nome;
      edtTelefone.Text := LPessoa.telefone.ToString;
      mskCpf.Text := LPessoa.cpf;
    end;
  finally

  end;
end;

procedure TfrmCadastroCliente.FormShow(Sender: TObject);
begin
  ExibirForm();
end;

procedure TfrmCadastroCliente.frmBotaoCancelarspbBotaoCancelarClick(
  Sender: TObject);
begin
  Close();
end;

procedure TfrmCadastroCliente.frmBotaoExcluirspbBotaoExcluirClick(
  Sender: TObject);
begin
  ExcluirCliente;
end;

procedure TfrmCadastroCliente.lblInformacoesGerenciaisspbBotaoPrimarioClick(
  Sender: TObject);
begin
  CadastrarCliente;
end;

end.
