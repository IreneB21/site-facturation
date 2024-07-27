const apiKey = '19f00edc-9363-3ab7-94d6-aaa0c9984351';

// Fonction pour mettre à jour les informations du client
function updateClientInfo(info) {
    const etablissement = info.etablissement;
    const uniteLegale = etablissement.uniteLegale;

    // Vérifie si les valeurs de nom et prénom sont nulles, utilise la dénomination légale à la place
    const nom = uniteLegale.nomUniteLegale || uniteLegale.denominationUniteLegale || "Non spécifié";
    const prenom = uniteLegale.prenom1UniteLegale || " ";

    // Met à jour les champs du formulaire avec les informations du client
    document.getElementById('lastname').value = nom.toUpperCase();
    document.getElementById('firstname').value = prenom.toUpperCase();
    document.getElementById('address').value = `${etablissement.adresseEtablissement.numeroVoieEtablissement} ${etablissement.adresseEtablissement.typeVoieEtablissement} ${etablissement.adresseEtablissement.libelleVoieEtablissement}, ${etablissement.adresseEtablissement.codePostalEtablissement} ${etablissement.adresseEtablissement.libelleCommuneEtablissement}`;
}

// Fonction pour ajouter des classes CSS
function addClasses(element, ...classes) {
    element.classList.add(...classes);
}

// Fonction pour retirer des classes CSS
function removeClasses(element, ...classes) {
    element.classList.remove(...classes);
}

// Fonction pour effacer le nom et l'adresse dans le formulaire
function clearClientInfo() {
    document.getElementById('lastname').value = '';
    document.getElementById('firstname').value = '';
    document.getElementById('address').value = '';
}

// Fonction pour déclencher l'API de l'INSEE
function fetchDataFromInsee(siret) {
    return fetch(`https://api.insee.fr/entreprises/sirene/V3.11/siret/${siret}`, {
        headers: {
            'Authorization': `Bearer ${apiKey}`
        }
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Erreur lors de la récupération des données');
        }
        return response.json();
    });
}

// Ajout de l'événement sur l'élément de SIRET
document.getElementById('siret').addEventListener('input', function() {
    const siretInput = this.value.trim();

    // Vérifie si le numéro de SIRET est vide
    if (siretInput.length === 0) {
        // Met à jour la classe du champ SIRET de manière neutre
        removeClasses(this, 'success', 'error');

        // Efface le nom et l'adresse du client
        clearClientInfo();
    }
    // Vérifie si la longueur du numéro de SIRET est égale à 14 chiffres
    else if (siretInput.length === 14) {
        // Met à jour la classe du champ SIRET en "success"
        removeClasses(this, 'error');
        addClasses(this, 'success');

        // Effectue la requête à l'API de l'INSEE
        fetchDataFromInsee(siretInput)
            .then(inseeData => {
                updateClientInfo(inseeData);
            })
            .catch(error => {
                console.error('Erreur lors de la requête API :', error);

                // Met à jour la classe du champ SIRET en "error"
                removeClasses(this, 'success');
                addClasses(this, 'error');

                // Efface le nom et l'adresse du client en cas d'échec
                clearClientInfo();
            });
    } else {
        // Met à jour la classe du champ SIRET en "error"
        removeClasses(this, 'success');
        addClasses(this, 'error');

        // Efface le nom et l'adresse du client en cas d'échec
        clearClientInfo();
    }
});
