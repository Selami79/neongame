// Setup when page loads
window.onload = function () {
    const urlParams = new URLSearchParams(window.location.search);
    const player_name = urlParams.get('player');

    if (player_name) {
        var input = document.getElementById('playerName');
        if (input) {
            input.value = player_name;
            input.readOnly = true;
            input.style.borderColor = "#0f0";
            input.style.color = "#0f0";
        }
    }
};

function submitToSL() {
    var name = document.getElementById('playerName').value;
    if (!name) { alert("Please enter your name!"); return; }

    const urlParams = new URLSearchParams(window.location.search);
    const sl_url = urlParams.get('sl_url');

    if (sl_url) {
        var finalScore = (typeof score !== 'undefined') ? score : 0;

        var dataPayload = {
            "name": name,
            "score": finalScore
        };

        var jsonString = JSON.stringify(dataPayload);

        fetch(sl_url, {
            method: 'POST',
            mode: 'no-cors',
            cache: 'no-cache',
            headers: {
                'Content-Type': 'text/plain'
            },
            body: jsonString
        }).then(response => {
            // Success (Assumed in no-cors)
            var btn = document.querySelector("#slInputArea button");
            if (btn) {
                btn.innerHTML = "✅ SENT!";
                btn.style.background = "#0f0";
                btn.disabled = true;
            }
        }).catch(error => {
            console.error("SL Error:", error);
            alert("Connection Error. Please try again.");
        });
    } else {
        alert("Offline Mode: Score cannot be saved to SL.");
    }
}
