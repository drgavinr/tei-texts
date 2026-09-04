# An interim TEI edition of Nehemiah Wharton's letters, edited by Gavin Robinson

Letters written by Nehemiah Wharton, a parliamentarian soldier in the English Civil War, in 1642.

## Contents

- [Introduction](#introduction)
- [Human-readable text](#human-readable-text)
- [Source files](#source-files)
- [To do](#to-do)
- [Copyright](#copyright)

## Introduction

Nehemiah Wharton's letters are well-known and valuable sources for the history of the English Civil War but they have not been served well by historians or documentary editors. Several editions have been published in print, but silent, and in some editions inconsistent, modernization makes them unsuitable for academic research. The first edition, by Sir Henry Ellis, contains serious transcription errors that sometimes render the text nonsensical and make this edition unfit for any purpose. My own attempt at providing a better version of the text in 2012 was not good enough, and is no longer available. The present version corrects some transcription errors that I made in 2012.

Anyone who can read the handwriting well enough can go back to the manuscripts, but the original text is full of traps, especially for historians who dip in for examples without knowing enough context. The letters will continue to be used because they include evidence about memories, emotions, material objects, social networks, food, animals, landscapes and almost certainly other topics that historians have not yet thought of investigating.

The definitive scholarly edition of Wharton's letters is needed but might never be published. In the meantime I have made this work in progress available in order to:

- provide accurate transcripts suitable for academic research.
- showcase my palaeography and XML skills.
- demonstrate how TEI XML can make documentary editing easier and more rigorous.

As far as I know, this is the only published transcript that:

- retains all original orthography.
- does not add punctuation.
- consistently indicates deletions, additions, and gaps.
- flags uncertain words.
- is marked up with TEI XML.

It is not a complete scholarly edition as it does not include any editorial notes or an index of names. This is a serious omission because Wharton's own identifications of people and their houses can be very misleading.

## Human-readable text

Three versions of the text are available, with different transcription conventions designed for different purposes:

- [diplomatic](https://drgavinr.github.io/tei-texts/wharton-diplomatic/): preserves original orthography as far as possible and does not expand abbreviations.
- [clean](https://drgavinr.github.io/tei-texts/wharton-clean/): a more readable version of the text with silent expansions and regularizations.
- [intermediate](https://drgavinr.github.io/tei-texts/wharton-intermediate): part way between the two, with silent regularization of some archaic letter forms, and expansions in square brackets.

## Source files

- wharton.xml: TEI XML source file containing transcribed text with markup tags.
- wharton-schema.rnc: schema that defines which tags are allowed in the XML file.
- XSL files for transforming XML to HTML. These generate human-readable text with different transcription conventions from the same XML source file:
	- wharton-clean-html.xsl: a clean transcript for ease of reading.
	- wharton-diplomatic-html.xsl: a diplomatic transcript that preserves the original orthography as far as possible.
	- wharton-intermediate-html.xsl: part way between clean and diplomatic, likely to be most useful for research purposes.
	- wharton-include.xsl: templates shared by the above XSL files.
- /html/ source files for HTML pages generated from the XML source file using the XSL files listed above. The files in this directory will only allow you to view the HTML source code. To read the text in a web browser, go to [https://drgavinr.github.io/tei-texts/](https://drgavinr.github.io/tei-texts/).

## To do

Although the version of the text provided here is more accurately transcribed and has more rigorous editorial conventions than other known editions, it is a provisional work in progress intended to make a better version of the text widely available as soon as possible. It is not a complete scholarly edition. Many more things remain to be done, and I will not necessarily do them all myself.

- Consult, and if possible photograph, the original manuscripts at Kew in order to:
	- see whether punctuation in the last letter has been added in different ink.
	- resolve uncertain and illegible words as far as possible.
	- proofread the whole transcript against better images. If the originals cannot be photographed, this should at least be redone from the microfilm.
- Compile a complete list of Ellis's transcription errors. This might best be done by producing a TEI edition of Ellis's edition with XML tags to indicate his errors and silent regularizations.
- Identify all named entities. Particularly important because Wharton's own identifications can be misleading and have sometimes caught me out in the past.
- Get external identifiers for identified entities.
- Catalogue all of George Willingham's letters. More are scattered among State Papers Domestic, as well as the famous ones in the British Library, Sloane MS 2035B. Ideally every archive should be searched. It will be particularly important to investigate Willingham's business activities as a merchant and find out whether he traded in enslaved African people or the cash crops that they produced with their unpaid labour.
- If copyright clearance for unpublished letters can be obtained, transcribe all of George Willingham's letters to the same standard as Wharton's letters. This would provide what is arguably the proper context for Wharton's letters. They have usually been cherry-picked by people who are mostly interested in the military history of the English Civil War, but this may not be the best or only way to look at them.
- Pull together any information about Willingham's involvement with the Painter Stainers' Company and the Honourable Artillery Company. Ismini Pells and David Lawrence already know something about this.
- Get Willingham's signature from the original will in PROB 10 if it survives.
- Find any other documents relating to George Willingham or his family or friends. There are two possible Chancery cases: [TNA, C 8/78/130](https://discovery.nationalarchives.gov.uk/details/r/C5415726) and [TNA, C 8/89/10](https://discovery.nationalarchives.gov.uk/details/r/C5456891).
- Find locations for Denzil Holles during the period covered by the letters. This should start with the *Commons Journal* and the Committee of Safety warrants in SP 28/261, which would show when he was in London. It may be useful to do the same for Sir John Meyrick.
- Some parish loss accounts in SP 28 and elsewhere may give more information about soldiers' activities and civilians' experiences of them, although the chances of matching a particular loss to an incident mentioned in Wharton's letters will be low.
- It may be useful to consult all original documents relating to John Penruddock's compounding case, as his petition mentions the soldiers plundering his house in 1642: CCC, vol. 4, p. 3154, [Hathi Trust](https://babel.hathitrust.org/cgi/pt?id=uiug.30112107844703&seq=772).
- The printed army list republished by Peacock has often been used to provide context for Wharton's letters, but its own context and provenance need to be better understood. Who compiled the list? Where did they get their information? Why was it published? It should also be checked against financial records. Alan Turton has done some of this for cavalry troops and found some likely errors in the printed list, but more needs to be done.
- Complete cataloguing and indexing of SP 28, SP 24 and E 121 would probably lead to more information about parliamentarian military units and personnel mentioned in the letters, even if there are no mentions of Wharton himself, and would benefit many other research projects. See [notes on military careers](https://github.com/drgavinr/cc-by-data/blob/main/army-pay/military-careers.md) for more information. Original signatures on receipts and accounts are particularly valuable for identifying people. It would at least be useful to compile all financial records of Holles's regiment that can be found in obvious places.

## Copyright

The original text is out of copyright in the UK because it was first published in 1853, and the author lived in the 17th-century, and so must have died a long time before publication. It is likely to be out of copyright in all territories that have standard terms for published works based on the author's life.

Any rights held by Gavin Robinson in the source code or documentation are waived by CC0.
