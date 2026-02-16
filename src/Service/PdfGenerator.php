<?php

namespace App\Service;

use Dompdf\Dompdf;
use Dompdf\Options;

class PdfGenerator
{
    public function generate(string $html): string
    {
        $options = new Options();
        $options->set('defaultFont', 'Arial');
        $options->setIsRemoteEnabled(true);

        $dompdf = new Dompdf($options);
        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->render();

        return $dompdf->output();
    }
}
