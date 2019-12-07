Example for use of [hledger](https://hledger.org/).

See [Blog post](https://www.gizra.com/content/plain-text-accounting-hledger/)

## Install

* `brew` from [here](https://hledger.org/download.html#binary-packages)
* Or `stack` from [here](https://hledger.org/download.html#building-from-source)
* Or with Docker `docker pull dastapov/hledger`

## Ledger-UI

`hledger-ui -f hledger.journal   --watch -b='last week' -2` and then: right, F (shift + f) to see future events

Or with Docker

`docker container run --rm -it --volume="$PWD:/data" dastapov/hledger hledger-ui -f /data/hledger.journal --watch -b='last week' -2`

## More examples

Get all Israeli credit card expenses by month

`hledger -f hledger.journal reg -H expenses:israel:cc -3 -M`

## Reorder dates

We can use `hledger -f hledger.journal check-dates` to confirm all transactions
are ordered by date.

If they are not, we can use `./reorder-journal.sh hledger.journal` to have it
re-ordered.
