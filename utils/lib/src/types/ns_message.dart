import 'package:utils/utils.dart';
import 'package:meta/meta.dart';

enum Codigos
{
  Sucesso,
  SemConexaoDisponivel,
  AlertDialog_showNSDialog_NullMessage,
  BusinessLogin_processLoginResult_CredencialInvalida,
  BusinessLogin_processLoginRemotoResult_CredencialInvalida,
  BusinessLogin_processLoginResult_Exception,
  BusinessLogin_processLoginRemotoResult_Exception,
  RecuperarSenhaBusiness_cnpj_invalido,
  RecuperarSenhaBusiness_cnpj_em_branco
}

class NSMessage<Generico>
{
  Codigos codigo;
  bool sucesso;
  bool aviso;
  bool erro;
  bool tentarNovamente;
  Generico retorno;
  Exception excecao;
  Error error;
  String mensagemCompleta;
  String mensagemAmigavel;

  NSMessage._();//Tipo privado de construtor

  static int codigoUnico(Codigos codigo)
  {
    switch(codigo)
    {
      default:
        return Codigos.Sucesso.index;
    }
  }

  static NSMessage<Generico> obterSucesso<Generico>({String mensagem, Generico retorno})
  {
    mensagem = StringUtils.isNullOrEmpty(mensagem) ? NSConstants.DEFAULT_SUCCESS_MESSAGE : mensagem;

    NSMessage<Generico> ret = NSMessage._();
    ret.codigo = Codigos.Sucesso;
    ret.sucesso = true;
    ret.aviso = false;
    ret.erro = false;
    ret.retorno = retorno;
    ret.excecao = null;
    ret.mensagemCompleta = mensagem;
    ret.mensagemAmigavel = mensagem;

    return ret;
  }

  static NSMessage<Generico> obterAviso<Generico>
  ({
    @required Codigos codigo,
    bool tentarNovamente = false,
    Generico retorno,
    Object problem,
    String mensagemCompleta,
    String mensagemAmigavel,
    bool logProblem = false
  })
  {
    mensagemAmigavel = StringUtils.isNullOrEmpty(mensagemAmigavel) ? NSConstants.DEFAULT_WARNING_MESSAGE : mensagemAmigavel;

    Exception excecao = problem is Exception ? problem : null;
    Error error = problem is Error ? problem : null;

    NSMessage<Generico> ret = NSMessage._();
    ret.codigo = codigo;
    ret.sucesso = false;
    ret.aviso = true;
    ret.erro = false;
    ret.tentarNovamente = tentarNovamente;
    ret.retorno = retorno;
    ret.error = error;
    ret.excecao = excecao;
    ret.mensagemCompleta = mensagemCompleta;
    ret.mensagemAmigavel = mensagemAmigavel;

    if(logProblem && problem != null) {
      AppUtils.printLog(problem.toString());
    }

    return ret;
  }

  static NSMessage<Generico> obterErro<Generico>
  ({
    @required Codigos codigo,
    bool tentarNovamente = false,
    Object problem,
    String mensagemCompleta,
    String mensagemAmigavel,
    bool logProblem = false
  })
  {
    Exception excecao = problem is Exception ? problem : null;
    Error error = problem is Error ? problem : null;

    mensagemAmigavel = StringUtils.isNullOrEmpty(mensagemAmigavel) ? NSConstants.DEFAULT_ERROR_MESSAGE : mensagemAmigavel;

    NSMessage<Generico> ret = NSMessage._();
    ret.codigo = codigo;
    ret.sucesso = false;
    ret.aviso = false;
    ret.erro = true;
    ret.tentarNovamente = tentarNovamente;
    ret.retorno = null;
    ret.excecao = excecao;
    ret.error = error;
    ret.mensagemCompleta = mensagemCompleta;
    ret.mensagemAmigavel = mensagemAmigavel;

    if(logProblem && problem != null) {
      AppUtils.printLog(problem.toString());
    }

    return ret;
  }

  NSMessage<T> castWithoutReturn<T>() {
    if(sucesso) {
      return NSMessage.obterSucesso(mensagem: mensagemAmigavel);
    }
    else if(aviso) {
      return NSMessage.obterAviso(
          codigo: codigo,
          mensagemCompleta: mensagemCompleta,
          mensagemAmigavel: mensagemAmigavel,
          problem: excecao == null ? error : excecao,
          tentarNovamente: tentarNovamente
      );
    }
    else {//Erro
      return NSMessage.obterErro(
          codigo: codigo,
          mensagemCompleta: mensagemCompleta,
          mensagemAmigavel: mensagemAmigavel,
          problem: excecao == null ? error : excecao,
          tentarNovamente: tentarNovamente
      );
    }
  }

  @override
  String toString() {
    String result = mensagemAmigavel;
    if(sucesso) {
      return result;
    }
    else {
      String problema = StringUtils.emptyString();
      if(AppUtils.isDebug()) {
        problema = StringUtils.isNullOrEmpty(mensagemCompleta) ? StringUtils.emptyString() : mensagemCompleta;

        if(excecao != null) {
          problema += (StringUtils.isNullOrEmpty(problema) ? StringUtils.emptyString() : StringUtils.newLineString()) + excecao.toString();
        }
        else if(error != null) {
          problema += (StringUtils.isNullOrEmpty(problema) ? StringUtils.emptyString() : StringUtils.newLineString()) + error.toString();
          problema += StringUtils.newLineString() + error.stackTrace.toString();
        }
      }

      String tipo = aviso ? 'aviso' : 'erro';
      result += ' (Código do ' + tipo + ': ' + codigo.index.toString() + ').' + StringUtils.newLineString() + problema;
    }

    return result;
  }
}