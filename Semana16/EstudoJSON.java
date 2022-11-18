package json;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class EstudoJSON {
    public static void main(String[] args) throws JSONException {
        adicaoSimplesDeDados();
        adicaoDeUmObjeto();
    }
    private static void adicaoSimplesDeDados() throws JSONException {
        //Criação do objeto carro e atribuição dos valores
        Carro carro = new Carro();
        carro.setId(1l);
        carro.setModelo("Celta");
        carro.setPlaca("AAA1234");

        //Criação do objeto carroJson
        JSONObject carroJson = new JSONObject();
        //Inserção dos valores do carro no objeto JSON
        carroJson.put("id", carro.getId());
        carroJson.put("Modelo", carro.getModelo());
        carroJson.put("Placa", carro.getPlaca());

        //Impressão do objeto JSON
        System.out.println(carroJson);
    }
    private static void adicaoDeUmObjeto() throws JSONException {
        Carro carro = new Carro();
        carro.setId(1l);
        carro.setModelo("Celta");
        carro.setPlaca("AAA1234");
        
        Carro carro2 = new Carro();
        carro2.setId(2l);
        carro2.setModelo("HB20");
        carro2.setPlaca("GBC8765");

        JSONObject carroJson = new JSONObject();
        //Adição do objeto carro
        carroJson.put("Carro", carro);
        carroJson.put("Carro2", carro2);

        System.out.println(carroJson);
    }
}