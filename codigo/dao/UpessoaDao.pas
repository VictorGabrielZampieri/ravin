unit UpessoaDao;

interface

uses
  Upessoa, FireDAC.Comp.Client, System.Generics.Collections;

type
  TPessoaDAO = class(TObject)

 private

  protected

  public
    function BuscarIdPessoaPorCpf(PCpf : String) : Integer;
    function BuscarCpfPessoa(PCpf : String) : String;
    function BuscarTodasPessoas(PTipoPessoa : char) : TList<TPessoa>;
    function BuscarPessoaPorId(PIdPessoa: Integer) : TPessoa;
    procedure InserirPessoa(PPessoa : TPessoa);
    procedure ExcluirPessoa(PIdPessoa: Integer);
    function BuscarIdPessoaMaisRecente(): Integer;
  end;

implementation

uses
  UdmRavin, System.SysUtils;

{ TPessoaDAO }

function TPessoaDAO.BuscarCpfPessoa(PCpf: String): String;
var
  LQuery : TFDQuery;
  LRow : String;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT cpf FROM pessoa WHERE cpf = :cpf';
   LQuery.ParamByName('cpf').AsString := PCpf;
  LQuery.Open();

  if not LQuery.IsEmpty then
  begin
    LRow := LQuery.FieldByName('cpf').AsString;
  end;
  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LRow;
end;

function TPessoaDAO.BuscarIdPessoaMaisRecente: Integer;
var
  LQuery : TFDQuery;
  LId : Integer;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT id FROM pessoa WHERE criadoEm = (select max(criadoEm) from pessoa)';
  LQuery.Open();

  if not LQuery.IsEmpty then
  begin
    Lid := LQuery.FieldByName('id').AsInteger;
  end;
  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LId;
end;

function TPessoaDAO.BuscarIdPessoaPorCpf(PCpf: String): Integer;
var
  LQuery : TFDQuery;
  LId : Integer;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT id FROM pessoa WHERE cpf = :cpf';
   LQuery.ParamByName('cpf').AsString := PCpf;
  LQuery.Open();

  if not LQuery.IsEmpty then
  begin
    LId := LQuery.FieldByName('id').AsInteger;
  end;
  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LId;
end;

function TPessoaDAO.BuscarPessoaPorId(PIdPessoa: Integer): TPessoa;
var
  LQuery : TFDQuery;
  LPessoa : TPessoa;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT * FROM pessoa where id = :id';
  LQuery.ParamByName('id').AsInteger := PIdPessoa;
  LQuery.Open();
  LPessoa := nil;
try
begin
     if not LQuery.IsEmpty then
    begin
      LPessoa := TPessoa.Create();
      LPessoa.id := LQuery.FieldByName('id').AsInteger;
      LPessoa.nome := LQuery.FieldByName('nome').AsString;
      LPessoa.tipoPessoa := LQuery.FieldByName('tipoPessoa').AsString;
      LPessoa.cpf := LQuery.FieldByName('cpf').AsString;
      LPessoa.telefone := LQuery.FieldByName('telefone').AsInteger;
      LPessoa.email := LQuery.FieldByName('email').AsString;
      LPessoa.dataNascimento := LQuery.FieldByName('dataNascimento').AsDateTime;
      LPessoa.ativo := LQuery.FieldByName('ativo').AsBoolean;
      LPessoa.criadoEm := LQuery.FieldByName('criadoEm').AsDateTime;
      LPessoa.criadoPor := LQuery.FieldByName('criadoPor').AsString;
      LPessoa.alteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
      LPessoa.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;
    end;
end;

  finally
    LQuery.Close();
    FreeAndNil(LQuery);
end;
  Result := LPessoa;
end;

function TPessoaDAO.BuscarTodasPessoas(PTipoPessoa: char): TList<TPessoa>;
var
  LQuery : TFDQuery;
  LPessoa : TPessoa;
  LListaPessoas : TList<TPessoa>;
begin
  LQuery := TFDQuery.Create(nil);
  LListaPessoas := TList<TPessoa>.Create;
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT * FROM pessoa where tipoPessoa = :tipoPessoa';
  LQuery.ParamByName('tipoPessoa').AsString := PTipoPessoa;
  LQuery.Open();
  LQuery.First;
  LPessoa := nil;
try
begin
    while not LQuery.Eof do
    begin
      LPessoa := TPessoa.Create();
      LPessoa.id := LQuery.FieldByName('id').AsInteger;
      LPessoa.nome := LQuery.FieldByName('nome').AsString;
      LPessoa.tipoPessoa := LQuery.FieldByName('tipoPessoa').AsString;
      LPessoa.cpf := LQuery.FieldByName('cpf').AsString;
      LPessoa.telefone := LQuery.FieldByName('telefone').AsInteger;
      LPessoa.email := LQuery.FieldByName('email').AsString;
      LPessoa.dataNascimento := LQuery.FieldByName('dataNascimento').AsDateTime;
      LPessoa.ativo := LQuery.FieldByName('ativo').AsBoolean;
      LPessoa.criadoEm := LQuery.FieldByName('criadoEm').AsDateTime;
      LPessoa.criadoPor := LQuery.FieldByName('criadoPor').AsString;
      LPessoa.alteradoEm := LQuery.FieldByName('alteradoEm').AsDateTime;
      LPessoa.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;
      LListaPessoas.Add(LPessoa);
      LQuery.next;
    end;
end;

  finally
    LQuery.Close();
    FreeAndNil(LQuery);
end;
  Result := LListaPessoas;
end;

procedure TPessoaDAO.ExcluirPessoa(PIdPessoa: Integer);
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);

  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Add('DELETE FROM pessoa WHERE id = :id');
  LQuery.ParamByName('id').AsInteger := PIdPessoa;
  LQuery.ExecSQL();
                          ////////////////////////////////////
  FreeAndNil(LQuery);
end;

procedure TPessoaDAO.InserirPessoa(PPessoa: TPessoa);
var
  LQuery : TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  with LQuery do
  begin
  Connection := dmRavin.cnxBancoDeDados;
  SQL.Add('INSERT INTO pessoa ');
  SQL.Add(' (nome, tipoPessoa, cpf, telefone, dataNascimento, email, ativo, criadoEm, criadoPor, alteradoEm, alteradoPor) ');
  SQL.add(' VALUES  (:nome, :tipoPessoa, :cpf, :telefone, :dataNascimento, :email, :ativo, :criadoEm, :criadoPor, :alteradoEm, :alteradoPor)');

  ParamByName('nome').AsString := PPessoa.nome;
  ParamByName('tipoPessoa').AsString := PPessoa.tipoPessoa;
  ParamByName('cpf').AsString := PPessoa.cpf;
  ParamByName('telefone').AsInteger := PPessoa.telefone;
  ParamByName('dataNascimento').AsDate := PPessoa.dataNascimento;
  ParamByName('email').AsString := PPessoa.email;
  ParamByName('ativo').AsBoolean := PPessoa.ativo;
  ParamByName('criadoEm').AsDateTime := PPessoa.criadoEm;
  ParamByName('criadoPor').AsString := PPessoa.criadoPor;
  ParamByName('alteradoEm').AsDateTime := PPessoa.alteradoEm;
  ParamByName('alteradoPor').AsString := PPessoa.alteradoPor;
  ExecSQL();
  end;

  FreeAndNil(LQuery);
end;


end.

