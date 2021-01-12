import 'package:utils/utils.dart';

class NSConstants {
  //Strings de Sistema
  static const String VALIDACAO_REDE_1 = "google.com";
  static const String VALIDACAO_REDE_2 = "bing.com";

  //Strings de Mensagens (não utilizar ponto final no fim de mensagens)
  static const String DEFAULT_SUCCESS_MESSAGE =
      "Operação realizada com sucesso";
  static const String DEFAULT_ERROR_MESSAGE =
      "Houve um problema ao realizar a operação";
  static const String DEFAULT_WARNING_MESSAGE =
      "A operação foi realizada com ao mesnos uma ressalva";

  static const String NS_ALTERT_DIALOG_NULL_NSMESSAGE =
      "Não há mensagem de retorno para ser exibida";
  static const String OPERACAO_COM_SUCESSO = "Operação realizada com sucesso";
  static const String SEM_CONEXAO_DISPONIVEL =
      "Não há conexão de dados disponível para realizar a operação";
  static const String CREDENCIAIS_INVALIDAS =
      "As credenciais fornecidas não correspondem com nenhuma credencial válida";
  static const String LOGIN_CATCH =
      "Não foi possível realizar o login. Por favor, tente novamente";

  //Mensagens constantes
  static final NSMessage MSG_SUCESSO_PADRAO =
  NSMessage.obterSucesso(mensagem: OPERACAO_COM_SUCESSO);

  static final NSMessage MSG_SEM_CONEXAO_DISPONIVEL = NSMessage.obterErro(
      codigo: Codigos.SemConexaoDisponivel,
      mensagemCompleta: SEM_CONEXAO_DISPONIVEL,
      mensagemAmigavel: SEM_CONEXAO_DISPONIVEL);

  //Mensagens padrão com retorno
  static NSMessage getOperacaoComSucessoPadrao<T>({T msgResult}) {
    return NSMessage.obterSucesso<T>(
        mensagem: OPERACAO_COM_SUCESSO, retorno: msgResult);
  }
}
