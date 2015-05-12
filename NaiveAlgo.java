import java.io.*;
import java.util.*;

public class NaiveAlgo {

	static int SCOREBUFFER = 2; //amount of rows before scores begin
	static int SCORESIZE = 26;
	static int MAXCLOTHESCATEGORIES = 2;
	static int MAXOUTFITS = 5;
	static int TOPINDEX = 0;
	static int BOTTOMINDEX = 1;
	
	static String[] COLORINDICES = {"Black","Light Blue","Blue","Dark Blue","White","Light Brown","Brown","Dark Brown","Light Gray","Gray","Dark Gray","Light Red","Red","Dark Red","Light Green","Green","Dark Green","Light Orange","Orange","Dark Orange","Light Purple","Purple","Dark Purple","Light Yellow","Yellow","Dark Yellow"};
	
	public static void main(String[] args) throws IOException {
		//getting command line arguments
		String color = args[0];
		String category = args[1];
		
		// Generating all matrices
		String bottomFirstCSV = "./scoringCSVs/Algorithm_Scoring_System_Bottom_First.csv";
		String topFirstCSV = "./scoringCSVs/Algorithm_Scoring_System_Top_First.csv";
		int[][] bottomFirstScores = new int[SCORESIZE][SCORESIZE];
		int[][] topFirstScores = new int[SCORESIZE][SCORESIZE];
		bottomFirstScores = buildScoresMatrix(bottomFirstCSV);
		topFirstScores = buildScoresMatrix(topFirstCSV);
		
		ArrayList<String[]> test = new ArrayList<String[]>();
		// getting outfits and printing them back
		if(category.equals("Bottoms")) {
			test = generateOutfitProperties(color,category,bottomFirstScores);
		} else {
			test = generateOutfitProperties(color,category,topFirstScores);
		}
		printArrayListMAT(test);
	}

	public static void print2DMatrix(int[][] matrix) {
		for(int row=0; row<matrix.length; row++) {
			for(int col=0; col<matrix[row].length; col++) {
				System.out.print(matrix[row][col] + " ");
			}
			System.out.println("");
		}
	}
	
	public static void printArrayListMAT(ArrayList<String[]> matrix) {
		for(int row=0; row<matrix.size(); row++) {
			for(int col=0; col<matrix.get(row).length; col++) {
				System.out.print(matrix.get(row)[col] + ",");
			}
			System.out.println("");
		}
	}
	
	
	public static int[][] buildScoresMatrix(String csvFilePath) throws IOException {
		BufferedReader in = new BufferedReader(new FileReader(csvFilePath));
		String line;
		String cvsSplitBy = ",";
		int[][] scores = new int[SCORESIZE][SCORESIZE];
		
		//getting to the buffer 
		for(int i=0; i< SCOREBUFFER; i++) {
			in.readLine();
		}
		
		//parsing the csv file
		for(int row = 0; row<SCORESIZE; row++) {
			line = in.readLine();
			String[] splitLine = line.split(cvsSplitBy);
			
			for(int col=0; col<SCORESIZE; col++){
				scores[row][col] = Integer.parseInt(splitLine[col+SCOREBUFFER]);
			}
		}
		return scores;
	}
	
	public static ArrayList<String[]> generateOutfitProperties(String color, String category, int[][] scoringMatrix){
		ArrayList<String[]>outfits = new ArrayList<String[]>();
		int colorIndex = Arrays.asList(COLORINDICES).indexOf(color);
		
		int maxScore = getMaxScore(color,category,scoringMatrix);
//		System.out.println(maxScore);
		
		String[] outfitProperties = new String[2];
		if (category.equals("Tops")) {
			outfitProperties[TOPINDEX] = color;
			for(int row = 0; row<SCORESIZE; row++){
				if(scoringMatrix[row][colorIndex] == maxScore) {
					outfitProperties[BOTTOMINDEX] = COLORINDICES[row];
					outfits.add(outfitProperties.clone());
				}
			}
		} else {
			outfitProperties[BOTTOMINDEX] = color;
			for(int col = 0; col < SCORESIZE; col++) {
				if(scoringMatrix[colorIndex][col] == maxScore) {
					outfitProperties[TOPINDEX] = COLORINDICES[col];
					outfits.add(outfitProperties.clone());
				}
			}
		}
		
		return outfits;
	}

	public static int getMaxScore(String color, String category, int[][] scoringMatrix) {
		int maxScore = -99999;
		int colorIndex = Arrays.asList(COLORINDICES).indexOf(color);
		
		if (category.equals("Tops")) {
			for(int row = 0; row<SCORESIZE; row++){
				if(scoringMatrix[row][colorIndex] > maxScore){
					maxScore = scoringMatrix[row][colorIndex];
				}
			}
		} else {

			for(int col = 0; col < SCORESIZE; col++) {
				if(scoringMatrix[colorIndex][col] > maxScore){
					maxScore = scoringMatrix[colorIndex][col];
				}
			}
		}
		return maxScore;
	}
	
}
