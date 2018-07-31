package br.com.urionlinejudge;

import java.util.Scanner;

public class P1001 {

	/*
	 * https://www.urionlinejudge.com.br/judge/en/runs/add/10011
	 */
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		
		int A, B, X;
		
		A = sc.nextInt();
		B = sc.nextInt();
		
		X = A + B;
		
		System.out.println("X = " + X);
		
		sc.close();

	}

}
