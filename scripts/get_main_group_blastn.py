#! /usr/bin/env python3
import sys
from collections import defaultdict
from collections import Counter

class ReadSource:
    def __init__(self):
        self._list_len = 10
        self.value_list = list()

    def add_value(self, evalue, taxid, tax):
        if len(self.value_list) > self._list_len:
            # sort value only if the length of the list is longer than
            # the max length by self._list_len
            if evalue < self.value_list[-1][0]:
                self.value_list.append(
                    (evalue, taxid, tax)
                )
                self.value_list = sorted(
                    self.value_list,
                    key = lambda a: a[0]
                )[0:self._list_len]
            else:
                pass
        else:
            # add the value directly if the length of value list is short.
            self.value_list.append(
                (evalue, taxid, tax)
            )

    def get_main_taxid(self):
        taxid_count = Counter(
            a[1] for a in self.value_list
        )
        return sorted(
            taxid_count.items(),
            key = lambda a: a[1],
            reverse = True
        )[0][0]

    def get_all_taxids(self):
        taxis_count = Counter(
            a[1] for a in self.value_list
        )
        return list(taxid_count.keys())

    def get_main_tax(self):
        tax_count = Counter(
            a[2] for a in self.value_list
        )
        return sorted(
            tax_count.items(),
            key = lambda a: a[1],
            reverse = True
        )[0][0]

    def get_all_taxs(self):
        tax_count = Counter(
            a[2] for a in self.value_list
        )
        return list(tax_count.keys())

    def __repr__(self):
        tax_count = Counter(
            a[2] for a in self.value_list
        )
        return '; '.join(
            ['{}:{}'.format(a, b )
             for a, b in tax_count.items()]
        )


if __name__ == '__main__':
    # file columns
    #   1. qseqid 2. sseqid 3. pident 4. length
    #   5. mismatch 6. gapopen 7. qstart 8. qend
    #   9. sstart 10. send 11. evalue 12. bitscore
    #   13. sscinames 14. staxids 15. sskingdoms

    aim_taxonomy_group = sys.argv[1]
    aim_taxonomy_ids = sys.argv[2].strip().split(',')
    infile = open(sys.argv[3], 'r')
    outfile = open(sys.argv[4], 'w')

    readinfo = defaultdict(ReadSource)

    # count taxonomies
    for line in infile:
        splits = line.strip().split('\t')
        readid = splits[0]
        evalue = float(splits[10])
        scinames = splits[12].split(';')
        taxids = splits[13].split(';')
        kingdoms = splits[14].split(';')
        unprocess_flag = 1
        for i, taxid in enumerate(taxids):
            if taxid in aim_taxonomy_ids:
                readinfo[readid].add_value(
                    evalue, taxid,
                    aim_taxonomy_group
                )
                unprocess_flag = 0
                continue
            else:
                pass
        if unprocess_flag:
            readinfo[readid].add_value(
                evalue, taxids[0], kingdoms[0]
            )
        else:
            pass

    # output result
    for a, b in readinfo.items():
        taxids = b.get_all_taxids()
        tax = b.get_main_tax()
        for taxid in taxids:
            if taxid in aim_taxonomy_ids:
                tax = aim_taxonomy_group
        outfile.write('{}\t{}\n'.format(a, tax))
    infile.close()
    outfile.close()
