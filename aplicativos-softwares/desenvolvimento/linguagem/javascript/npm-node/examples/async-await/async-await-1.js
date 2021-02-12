main();

var a = 0;

async function main() {
    var um = await funcaoUm();
    var dois = await funcaoDois();
    var tres = await funcaoTres();
    var pA = await printA();

    console.log(um);
    console.log(dois);
    console.log(tres);
}

async function funcaoUm() {
    await sleep(1000);
    return "Um";
}

async function funcaoDois() {
    await sleep(500);
    a=2;
    return "Dois";
}

async function funcaoTres() {
    await sleep(250);
    return "Três";
}

function sleep(ms = 0) {
  return new Promise(r => setTimeout(r, ms));
}

function printA() {
    console.log(a);
}
