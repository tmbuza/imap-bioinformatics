INPUTDIR="resources/test"
FILESDIR="config"
OUTDIR="data/reads"
METADATADIR="data/metadata"


mkdir -p "${OUTDIR}" "${METADATADIR}"

cp "${INPUTDIR}"/*.gz "${OUTDIR}"

cp "${FILESDIR}"/units.tsv "${METADATADIR}"/test.files
