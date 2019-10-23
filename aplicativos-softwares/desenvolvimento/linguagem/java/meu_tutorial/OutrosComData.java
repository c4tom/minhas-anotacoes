import java.time.format.DateTimeFormatter;
import java.time.LocalDate;
import java.util.Date;
import java.util.Calendar;

public class OutrosComData {
    public static LocalDate dataAgora = LocalDate.now();

    public static void main(String[] args) {
		Date date = new Date();

        System.out.println(date);       
        System.out.println(OutrosComData.dateAdd(-100,0,30));
    }


    /*
	 * Aumenta ou Diminui a data por ano mes e dia
	 * Retorna dd/mm/aaaa
	 */
	public static String dateAdd(int ano, int mes, int dia) {
		
		String DATE_FORMAT = "dd/MM/yyyy";
		LocalDate date =  OutrosComData.dataAgora.plusDays(dia).plusMonths(mes).plusYears(ano);
		return date.format(DateTimeFormatter.ofPattern(DATE_FORMAT));

	}
}